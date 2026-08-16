Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B0EC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcFB-0003iN-GB; Sun, 16 Aug 2026 10:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcFA-0003g2-IU
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcF8-0002Zz-QD
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:53:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkn9K2760476
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s6bPi+RFkQqSYlbr8FSTtHoAF6m9DnNo7b6G/QSiEVU=; b=FWBBucZ2/WC5LXau
 B17b51d48mDzzE6DyjeFFOvez2hX3cLyco8ryBDuWdbnIfxcRarQ2hTqlwkkcRND
 vswjsJVL7Z2Wz0w02TAh9h5aAZ6S5owqnuAHSwZ2C7QVFVD2Yq3EL93SWWPgVy5V
 2sy7uk+tSOtKRCzKleoimxfKf8W93DxfpUfN1xoQwr+1BGaelnHeCJS8MasqQ3KJ
 FzpgLbEW3QC8W4z+1re8A/5tFScKGjcyNRyfbM3MWmscrJN9TDzXbqAm87GqsS+i
 YuuvEXE8c4l6UIZ9SizfMCQBOOOwxX3dsu7moZ1ncmgMQJK4RohD09dfe86xuw45
 I2FwnA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkhe5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:53:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso24415771cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892024; x=1787496824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s6bPi+RFkQqSYlbr8FSTtHoAF6m9DnNo7b6G/QSiEVU=;
 b=gVewCSJO7UVU3SMTaCaN8hCS4DYl6CuUkLh7yLh1LVLAHWG9Oq4xULnOIziYOyZ+O4
 yeJFgkwOn0jNTu4WFvDBYIsBGCXWZBOMLcmLWmhPVCOhYHNSMuXCmrL+IZqAHXBpX+ir
 NaapPn2xlmu7LOtEa8kgJUKTUThqVgsrxoKDCuGnIjZaIOxZ/Yixs+xN18y3lhKEeB8p
 NcOR6hqg0PA18GBHLIIlVXOTvJXjJyfrJM3kRIe9z2YIXYaZQEepoal156GqSy6cCm09
 vw8aNTJrmPBvNUdTk6n1678lZY0UhvyUpKpBDlo7nwXqC7pHu7auITS8kEnXIjT02z2g
 4JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892024; x=1787496824;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s6bPi+RFkQqSYlbr8FSTtHoAF6m9DnNo7b6G/QSiEVU=;
 b=brPUf/lDgfux+0g8dJ7HYSO5L2/jsyf3JKJbS8l2y9UbSKzwgemoc5a6Q653Vru43e
 D3NS16oegohkd1O8zWp6qqkrCbqEwvt1TaNy6IokJr6F8iCCumCp3Ihq/IGjOrVH9wBU
 +IxXPUTxjjRWaIHZMTVHeaq96OxP3jN8DFrrp6HIF2TjLBY38v+E29rHMqc0VXCJ2INP
 ij3SzmMx7dwJIm5LRfcMgMCh/2XYPuxPAVO8iXROFFZFfVaDpM0Rww68TZdwApQV1kw7
 zcI6kS3EUVAYAD81Xqpd6Qx/+bYE3v8tX/YbrsXPja5hvl5+SFKeI1AGkThwiOwEc2bD
 4zNw==
X-Gm-Message-State: AOJu0YzkWuVuB05LsEjCJiHginNi0KT8igiHLC/E2+3pP/GfENN+7lr4
 dHSjBJ9b6ZAeOyGcTkMrB1gWeNdWKMG9lQvo6nR/bxEyv8CcL/grK47cuoYdFAK3lIs4uGTZOC3
 QJRwBJC3AI5xmS1eq2K75SFoTBpfmkHbdHitl4gwTmqG1pOrWoOtd5ht5gDL3dpFKeg==
X-Gm-Gg: AR+sD132LogqV2GZ++DKVK3wirKFPUMWIt8qunzl4sbJ/jsBRBfek+mScPdR/CWkwLR
 sShvNOaFF5pZb70gmBci2AwuacBXHMvw5mGaZjby/LItNFpEA1hkusp+M7+tW6r+uC/rZo4NWCT
 AXG/AB6IhpoCM79nXNz4go28Yb+I8KEXphlm2U1TmxV4oLZjTNI5TmRX6br7Me/RLoCX1ePj1yw
 Bvs8mTwuz4vVprhhhHgK6S4dL1uO3Pg7f2YPQ59Zk3jGAlgNuYAXnwJ1WHsDOnbUGjnxe9aKoU5
 P9dD63ZyQdRw6ohMYSRkq67FQd+uATjxn1mM+doIKMY5r15aueGOPvFu+wAimlYlPOylf3VCk/9
 YDY/LEzMHysNu0rOak2/FigPCZVF0L/1Uj9qTDEd6aQ==
X-Received: by 2002:a05:622a:1308:b0:517:6508:e1f4 with SMTP id
 d75a77b69052e-52d8551f3famr189640341cf.42.1786892024283; 
 Sun, 16 Aug 2026 07:53:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1308:b0:517:6508:e1f4 with SMTP id
 d75a77b69052e-52d8551f3famr189639951cf.42.1786892023672; 
 Sun, 16 Aug 2026 07:53:43 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b27bfsm26061411f8f.23.2026.08.16.07.53.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:53:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/56] hw/elf_ops: defend against weird elf headers
Date: Sun, 16 Aug 2026 16:45:54 +0200
Message-ID: <20260816144556.69009-56-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B7l9bupwziQz6KQ-qx4iN1C8CmAJzVVe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX7BX3j7X8EpyZ
 Wg+LE2NPWIo/C0OUdNfqQaCV9huqkIK3fRIJneo+lKt1B9RUg1GrvaCx0Zzx+3ljLyXAPbGDa3n
 HUEChQoLNoM6pjbh77ztPXmsx751itI=
X-Proofpoint-GUID: B7l9bupwziQz6KQ-qx4iN1C8CmAJzVVe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX5Z0orF+g0KdO
 w/Mt2HBp0BMJzn/joCbExCznoD7311SBVUab+STq1Dj9Sf9SOtLEUP4irOxuvYFSMEBdHmiQoM0
 8auIk6y3SS5n2pAc5Db+s5pmdFHKtLPvWA7GciUA8v0avotnuAGTQECTkUj8UmKPBBNPsBejEup
 2UnR9FTDvU+/i/KuRUdxTVJMbe7siqyO7TpkSABXJr09otnBgSkDicX1pD+1wGYXbCsO9lJMo7t
 ozUEYPIihgI6JjPhmQvaXMOYGlPYobGCG9G+q1ECRM5VlfaNtFLPyFrEMCmiVZMb9WBkqyyLK7o
 9Y1FqczXwwJAfV0dgzzj+1C4q7xhr7SKSH5c8YjbzGakcyLi/2+t0ySCbYoGzg2eC/Q3WklAR3B
 1Ja2PvVElu0qoBGeqhUanYLFFDqe8bBVGCtnSjUPCf6D9oX/kKxUALhBsdXsJuJDa73knvoA0YO
 LTTqLN/GHxHUqOjskFg==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81cef9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=OFwHzJbXOuJeDGjhX8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

According to the ELF spec:

  PT_LOAD

  The array element specifies a loadable segment, described by
  p_filesz and p_memsz. The bytes from the file are mapped to the
  beginning of the memory segment. If the segment's memory
  size (p_memsz) is larger than the file size (p_filesz), the
  ``extra'' bytes are defined to hold the value 0 and to follow the
  segment's initialized area. The file size may not be larger than the
  memory size. Loadable segment entries in the program header table
  appear in ascending order, sorted on the p_vaddr member.

which implies while both p_filesz and p_memsz can be zero we should
never see a case where p_filesz is greater than the in memory size.
Indeed it has been reported such a hand crafted ELF can blow up, for
example during rom_reset():

  address_space_set(rom->as, rom->addr + rom->datasize, 0,
                    rom->romsize - rom->datasize,
                    MEMTXATTRS_UNSPECIFIED);

which could trigger and underflow leaving QEMU slowly filling a very
large buffer.

Cc: qemu-stable@nongnu.org
Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4056
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260812081405.3811787-1-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/elf_ops.h.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 9c35d1b9da6..044e72de2a2 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -427,6 +427,11 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             file_size = ph->p_filesz; /* Size of the allocated data */
             data_offset = ph->p_offset; /* Offset where the data is located */
 
+            if (file_size > mem_size) {
+                ret = ELF_LOAD_TOO_BIG;
+                goto fail;
+            }
+
             if (file_size > 0) {
                 if (g_mapped_file_get_length(mapped_file) <
                     file_size + data_offset) {
-- 
2.53.0


