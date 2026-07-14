Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22809C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjivS-0001kh-2n; Tue, 14 Jul 2026 15:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivR-0001kP-6W
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivP-000588-Gb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIxKaJ1481546
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jc8C7QYNmUdHNgQ2t1bOW+qTywO+3Szw+HEi0uA96kc=; b=SLyA4JIJ6iOC0O13
 B6mYcgPE5knjyNhey6FDU5hJ543yrAFUzA7tBrcxs0smmmNRV0SA4+3ytX/hrECj
 WnjfpFdtyA7+AZEHvBQX0NSFRqbt8emXOPvJAH9YEGfzcp4BfuGSnBWD03RLZfp4
 SAVHUiAXX1qpyoWPebVcNnngRzcz1XSW79ljvukuIOJLmVc9H7x2hov0gwBnPGOd
 uUakhC1fiQDhgPbGvAEULyD4jqyFAi5BhqmQPU+ohdNrEI7o7davwwmDYv6G/jz1
 h0ESjZXOc1qKY6c7Gn8Cf8gU+EXM45Zw4aA0gy1GSlOFC2C21jZJgMxx5IkzoVFO
 7OBJ2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudjt21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e63df032bso141752485a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057774; x=1784662574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jc8C7QYNmUdHNgQ2t1bOW+qTywO+3Szw+HEi0uA96kc=;
 b=IAyUF6rg34RwnfdI32/smkqYKTPBmbaA+pUL//dCoGZGWApLWMuly2lgvusKs99qM6
 L2r+WDfC+MZuSS9krH3lp5cWhAkMxsvyFZhOQY7DL+GIrw9u40USABBTb2ql8NjuAExg
 HNXZvJYjM+YOArrd9uZmrbuTIXno2m6SCQ3ffQpWbZ0XDQIMdomIN0GHZ+sXdHVPLnUO
 Sa3dLF9CUaR356W5D3/iyv7Z6GQZDlG0nsaLiqxfAS4V1FziDM87wblVDTNG8rclBGq4
 oPyEGTdvyfKK1ZDdWxhFQ83uZ0E2pgn0usHp6/zkrRQj8E8mMGeo2Plj5cjerZ0aB93y
 odHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057774; x=1784662574;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jc8C7QYNmUdHNgQ2t1bOW+qTywO+3Szw+HEi0uA96kc=;
 b=dVTiUW3x3uExLJCD2234ISszkLstDWVYqI9D7Nt+d5py5c6nRI3CqHqSTn7THCjTS8
 jIngi24z6B5VlLFwUlO+uK0whiZoVnTMrtpk8z2fYC0yC31P5Vsw1+Axv1HWXi5XGx8m
 rQMC7qWKQKmhzcxVHnKIu8n34OgoTQTF5g3vdV1kXZEFvpdqFQ8UmY/xt1xcw3tBGURt
 pPHMZRv/GFZV0EfKuFRla/OIgqJA7PQ1jzxYKujFY2+ZkqSph6OWW5ZKlusM8hs16gHa
 Yp1Jos/aigU2AIKNMsAD7nb+pLGGwBUQJKP4zcc0EojTm7T5mI1kLonDp41iCby9gt+6
 FYXg==
X-Gm-Message-State: AOJu0YzgxE1fAmlv6Yrfhuz9GEVQJHDTYzJeP5HxlqGscDTmCHlfq2oH
 XJOBlXW9aEvi0DY+SMqrMozv8MfR9gDt46naKwBNpV1kXKhMLJjrtzCPsVV3om1ObAZYbJJxdjp
 ibznAH5T9/3fVmqYdhqPB3yXHCE1gBw0R5FlM6zLVS+6JptpiFIIwF3wg710nnXTyaQ==
X-Gm-Gg: AfdE7cl/jII3jkLQ9ZpfgNHCILnO6/ztS6pPF3aSO6pHQxCAgIeScQEEdyI3tv5zjT+
 CCeq25uAk5VuKP0LXloG1g0+B8Cgm4dXPAk5TzuMR1gBVDr/wubJtBz+25STminIROz84IMLW/r
 nXz91PD+LnzjJ6oEy7Qc5yWmI+ltXtUbgZYkEfAKCeR9UOVzaam6lXIplit2K3F1gcFvGerxgFU
 378qTXlQxLG99lcN6BQx5zirfg383Y04SzGomyEwF2cJdeEfU7GJxLenn/qFhRTFIJQxSh3YvlE
 F4j4QHQx7S+Q6aHWCoaqFZ0Jo1/2YDOZj4WJKxcmRdJ3ceUozsloiULNFVL22lQLDDNM05m/KOK
 R8Go+yc7dmldjppAbJT6hykJe4tWTw8JvPdN3piaBRb5GtCDJ+eQPEFnQZhhfetIyoEqp
X-Received: by 2002:a05:622a:506:b0:51c:7aa7:e0f0 with SMTP id
 d75a77b69052e-51caa1a740amr195706331cf.43.1784057773549; 
 Tue, 14 Jul 2026 12:36:13 -0700 (PDT)
X-Received: by 2002:a05:622a:506:b0:51c:7aa7:e0f0 with SMTP id
 d75a77b69052e-51caa1a740amr195706061cf.43.1784057772963; 
 Tue, 14 Jul 2026 12:36:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4829896asm8687196f8f.23.2026.07.14.12.36.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:36:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/13] hw/sparc64/niagara: use int64_t for vdisk size to avoid
 truncation
Date: Tue, 14 Jul 2026 21:35:11 +0200
Message-ID: <20260714193517.60708-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hHnx4bccr8JUB4ZQg247Oh7r8EznWYAf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfXxqbty+xPwitH
 2vJIMHxDQfzhBD9knZvdlrae6VDxuHyO9xru+SI59zgPd8Zqmrwi+TM2obeBP/YrbYYwXhuTynX
 vzVkxpKe2Gx1HEnA5WTjhJrTSjGrJL4PJspLEXn3bD7mQIPQoRmkcfS2Zv7XP93SjN/IKjasmOu
 p60hfTdGF+uCstjNvNukCxT0Ix64ik/jbI60qLPq+JoAsOCh8dcHOzCCfm8H+BgPTnIBJRwwzkq
 XuKheaPJauaqHdJcl7IdbnAD8WxgIo/jMw81HGbX3Q7Izf8b86VG6bzMtZ1agf0EPZI9WA966TA
 YuL4IHMC12M6YBa/BQOAu6Xf1LTXkZXdU3QvxWStZlUtamxH4SPCJP4IcXb8LJp3Z2N23Trvgf+
 2cQooEofuyuB9sTzz2cs1wkXz65pGN4QeamXYCTfjGJFb25fl52J47xXI8cqagBJuU6+BDhRHtT
 +d+6bI8iScsKwESccrA==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a568fae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=TUGr3rjMgH3xqUiw0coA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfXyHnL/VrqmEAT
 ER78YwTDiTXIRQkC4s6aeTm8JZsih7u+aPOTDSQ9glMDZ+tdPueqwc/sbYVk/dNWTMv1FrMoUh3
 ZOoojZQBXl/q/F+Yz8Bmmb6wFdmoewI=
X-Proofpoint-ORIG-GUID: hHnx4bccr8JUB4ZQg247Oh7r8EznWYAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
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

From: Dmitry Pimenov <sun4qemu@gmail.com>

blk_getlength() returns int64_t, but niagara_init() stored it in an int,
truncating the if=pflash virtual-ramdisk size for images >= 2 GiB. A ~4 GiB
image truncated to 0/negative, failed the `size > 0` check, and exit(1)'d
before the CPU ran, ending with:

  qemu-system-sparc64: could not load ram disk

Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260710222350.9185-1-sun4qemu@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/sparc64/niagara.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 1211ecb82d4..ad5e5945a85 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -137,7 +137,7 @@ static void niagara_init(MachineState *machine)
        outside of the partition RAM */
     if (dinfo) {
         BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
-        int size = blk_getlength(blk);
+        int64_t size = blk_getlength(blk);
         if (size > 0) {
             memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
                                    &error_fatal);
-- 
2.53.0


