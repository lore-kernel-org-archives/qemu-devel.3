Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5012CC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc9n-0003eV-Ij; Sun, 16 Aug 2026 10:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9E-0003UZ-Uu
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9C-0000m7-Sz
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlJuO2399156
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A9CsrQSlCyNXcPkrVRh5064XGBYvXQzeGZdmRaiZdAw=; b=Xs0tpe4e6d4x2Dlx
 ZwgOOTU/cMCMSU0oR8ixC3Qc9Eec+uv4sh2CXJ3oyMRskYm5W5eaCOhO1AtS63Nf
 X/1oSBq8Li5HIt+mry6rvWRI45BVCNCrBRgiG1qEY3vIAsHUupuiYd/TMPExjb5u
 VSTcJekg70LnTX8Zigwg7BK8GsRWLJWq9ucjs76Hz92JsP8oHiisp+R6ahyv00OM
 8qQNvWBZVmDQ0EtQKrvZon6POdfRxUPEdDDcmwlHX+nbbY19WQjWY6+EsTKjYQUn
 zW7sr1XbfoO7GD+GOsIxn3ptfzIht6kwRS1Rd3LCvMONi3hHHLQL6WkyF0iR3PeW
 mDX2Rw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq3nmh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bf321d786so36981341cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891657; x=1787496457; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A9CsrQSlCyNXcPkrVRh5064XGBYvXQzeGZdmRaiZdAw=;
 b=i5dpMgB8XvJuZ4siQVo1LHkPNudvJkTa0mStRC+XkHKrIypEY5PN/PasIje9IqMYt6
 2fERTvC8FKoAFTa+Qcyh4VmDJJqlYlzRc7IRe2Q/0XqQKbiLn55TXK91vnQ33ZEu+kI2
 Xt7d4mk39vNAs7xbNZ/p1utsX+G2YGtIRERnqGw+5rbIwDz1uPbzxZTrHlI3G3iPoMjV
 eF3Yzb/pfA7sSlQWdADfH9/li/0KLUWbSxuKplo/0aGaLJR77t+XUqtBpg9XoitQbC5Y
 zOJuUusXb60xMcZwE5tiWl3cnsnpJqWraN8G2Lho65ulDnqFLRhC+AxYXVK/Kb82QpXJ
 I06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891657; x=1787496457;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A9CsrQSlCyNXcPkrVRh5064XGBYvXQzeGZdmRaiZdAw=;
 b=MREGsEet/yxhEgNYgbadHUpmcqiL8BuYVtrn3g+uY6NJPLc2Zns9QQLhCcs5p55N/t
 JzzsdwoNpSFrqS6oQlWa0RW+6X7coGkJY7tMbNTtjGgEst+9KO/eOM05xFVi9MVR5vWm
 ehsBpV5AXq/0cq6TRjk6TzJkOj2iIZnAMrLjWRO2VX26vDRvX4fol/imnJ5HGit09VG0
 LqCmpbyfUtw1+q0LwKuVZjrLI8QZfzEWNGh9JDtPVRIrs+6vlNy2FgZ56y5L7l/Jyjw+
 wtkUtSkkaR2Ww8iLQFHLeE3dE7clO0v8rTxYAIudd39YwSI+5EvrXbzThVUiCOyR2gLt
 ZD5Q==
X-Gm-Message-State: AOJu0Yz+68g5+wFy/YKLsRyvw1kRMr7Skx3MOAT/QmLQPn7fo8tlf7MG
 rusQXrJOlunfI0Va+0NQnX/0NCfYX+I1CpBtFHpsHX5NA1uhxYQjLLcBgkxWl/tgBbIYMgf86bd
 LU/9o6u46M0q+Yt1MKrntzsXUCpgajZDXvV2NpzvZTrLCfU1401eeGDY8CTNcOO4m8g==
X-Gm-Gg: AR+sD12ppJOEg4crTi2y/VmKbznsQ1BP+zQ7DmNJRv2odxcBOfF2/7DgDNWoze8qsU3
 W6TZYjigGQM5aK0RS/SAmFsp+qKOH8Z+pJNJCyWjwgovc8DBB6JFiFgbrodF4mjZjn8P/zwnlUs
 DkbLBk18ze4gdz3bJib9cpqSBepgzYZbKl7Wj87FXKyrk+OTVysVjUN4K65YLFa1cjhXyBtkre0
 yFz1LHHKmK757J2QycHXWTJmNj3PIoVP2e8kYb66hW/UqgGibVCkz+6DX1pgKtzTsg3vRDXQKPE
 vMYYqKJ9ZK8IdqG6PmCDRWGZonVs14FTsccAw0wkBn8Uji488vT1LuzgcaAS42E+7BvviekZ1Dv
 +JSYlELEjWYHbkrzBj6JETR/dzgJc7KDPV1MTmuRy7A==
X-Received: by 2002:a05:622a:40cb:b0:528:38b1:b539 with SMTP id
 d75a77b69052e-52d8535038fmr211116711cf.10.1786891657154; 
 Sun, 16 Aug 2026 07:47:37 -0700 (PDT)
X-Received: by 2002:a05:622a:40cb:b0:528:38b1:b539 with SMTP id
 d75a77b69052e-52d8535038fmr211116421cf.10.1786891656702; 
 Sun, 16 Aug 2026 07:47:36 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d7974sm146752755e9.1.2026.08.16.07.47.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:47:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/56] hw/virtio/virtio-mem: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:10 +0200
Message-ID: <20260816144556.69009-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX4SH8JMbb/PdK
 gLtXd/D+AjMDWrLHWa/hvF/e6EezSanZMZglf3CixuCWHNSDxytgWw+krlnGCZ24YOJHNh1WaGm
 +/kU2nYOPbKR6mWqnOb8YEHZsNBxwHPGE2uU+nHMrm4bSiPplN2w3VloSO+y+Ekg7rIR2Bcf2Yu
 A2MUpACBa6J4nWk86kMo2stPCep20bYnTy1L0xQ0+dhUB9KXefTL4ZkgWyFSG2UTEL3JA5kypXW
 RvtEuU/UQj9GaS89nLy7XNZa+2XcZgO7HSXCGwRsJxpexU4XQzS94dfR7HGmXdLEPlIgC3cxbdj
 EIVs82PLQwmkZnT1savtdsU1S2HBzJ1QToypom+JsfWb2+aEQD3+0AVoIxL1AErnyAr/L8tX7yn
 94BMF22wU2MetxhG7YKGDMmeCpWgqH4gWf40apIbGbPSDdlgVVrOVuGloHJ/0QKj+usi8yiBuOI
 drg860rrI19o8P4D6SQ==
X-Proofpoint-ORIG-GUID: okZA1IRwjFg7eMb6VrNAuDUuE6Hjvtn2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX0PHXH2/e8Avq
 kaKFa+kP2fpE3jYzKytpCP6F/SqvK+FBTmgVtQGCoU/df8IZ9CQ+nU8MT1UoQFBVtyVX91Z8p8E
 U+vnUGH5dvSIwkFhZZHr6ghdufaS00M=
X-Proofpoint-GUID: okZA1IRwjFg7eMb6VrNAuDUuE6Hjvtn2
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a81cd89 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=uRxLgUfnyXHAhkBXUOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-10-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/virtio/virtio-mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 35e03ed7599..7130ed852d9 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1453,7 +1453,7 @@ static void virtio_mem_set_requested_size(Object *obj, Visitor *v,
      * The block size and memory backend are not fixed until the device was
      * realized. realize() will verify these properties then.
      */
-    if (DEVICE(obj)->realized) {
+    if (qdev_is_realized(DEVICE(obj))) {
         if (!QEMU_IS_ALIGNED(value, vmem->block_size)) {
             error_setg(errp, "'%s' has to be multiples of '%s' (0x%" PRIx64
                        ")", name, VIRTIO_MEM_BLOCK_SIZE_PROP,
@@ -1507,7 +1507,7 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
     VirtIOMEM *vmem = VIRTIO_MEM(obj);
     uint64_t value;
 
-    if (DEVICE(obj)->realized) {
+    if (qdev_is_realized(DEVICE(obj))) {
         error_setg(errp, "'%s' cannot be changed", name);
         return;
     }
-- 
2.53.0


