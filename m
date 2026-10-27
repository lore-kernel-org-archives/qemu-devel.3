Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D30606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lScPq3mA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AP7HAdE7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmoa-0004D9-Vn; Tue, 27 Oct 2026 15:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnG-0002ci-Vt
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnE-00023B-2t
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHvtw2961223
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uDig2pG9dIRX/TbDPHVfoBUkQ30vSYN1+1px9xW16O0=; b=lScPq3mAbQ2cKeUQ
 ibCJRi82fdN9+ZpVMBxSyEQVl10aO+pf0UsJyLAZJRlPuHn38WxJmdXdmnwIrozo
 RIKN05I18zLEt9gcJo7TPnDb0SYQfIl1ssR2bD0XVt93XBO8LlUeeFux0pWu7fLf
 c9yX1InxX0ijxd/x/jTIqmVmJmeCzGhY6YQzRqjK7+dMRhEgdLgo5y5+OOB+QhaU
 jPRggoF2oozv7GaUoScazHyOuU3pPJKak4LA2Y6tEmt/1zueT9YiOdGDivXowqmK
 j9kIezn6DSwNwiz8+CUFNMfVNgpZ057jov8tkpBqFM7a+2OzVtlLm+oZ9jF2A+U1
 cGjZGA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy670v26-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso18929485a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129106; x=1793733906; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uDig2pG9dIRX/TbDPHVfoBUkQ30vSYN1+1px9xW16O0=;
 b=AP7HAdE7eONP3L6D3VYSoZCtCQX9HFLkdTxWDC3Pu8/RFNqpBIRaKeQsAaZKdXvqYA
 2cmgbkfsDVyAWBzaS3+FbDP+2oQJv6IjcMKrKszZ8RhDCZ9K5CafDTp0mHMTwOysq7SG
 ngKLo+ehuT4mLYKMlOykLjNLXj3o225x/PpnduxO8goaH9BW0hUzHRCmH10nnu6Ctnvy
 LuoUMnckflBEutLkPHPD0bBSV29tcIwwrCV0vlfIpk32mmmM6TqfUxOIQM6Rt5cyiquJ
 fVeCZM4q8p2/BvNz7rUszT6gWFXSa2sjcrqM8dwicqoJ7r3ztjke8CnwZ5JEjGvFTsm+
 XCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129106; x=1793733906;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uDig2pG9dIRX/TbDPHVfoBUkQ30vSYN1+1px9xW16O0=;
 b=1ffxiX8svHKfydysRJ602Y1iBVpxGg1aFN8spcTuHj1BEfZOrLSsPY3uc05TVQ219H
 ZiEi0Mxp/CdW5aJAOs+e4AModTY0aH6leKM3StLP7wwaIP6G17qCqvH7+KJFmcB0+NgJ
 YutnFYWDkDBG1PkrUMYlmbBW0e42GLUyZ46GjkhL4cQNpD0lsa+B3D/A/AHZY91lU+4c
 GoKXioCh1B0XuljaKQhjBuiiS9UegV2V9aSjejGuyFBztwZB8XUHMaDI9VTBAzDOVpZj
 pZmY1EsbAiPm6hheLi9LmxjU/WiowJajPYMZzjSX5tmG+G0dqQ/KC/EGHtX5ETUQ7QrJ
 Q/wQ==
X-Gm-Message-State: AFq9FYJr0RzDMfB3BrJF+6sSajmRXEDuKqLnTynikR+MOx6818NT1Bd6
 WHHqEzHi53nnqX3N2VSxPuHCb1bfI3h9En55m6F8aOlpijBLuqAQ+yGN0T1z2noFMTgvO+Y92iS
 in3SPacyGQF+O3ybP5fHLJbaa7jRfz5s+gEEieJVT+KeZJQXJEEzpgIWKUonUmqKTSg==
X-Gm-Gg: AYBFou2kz3vtxarT/kbJJpxNa12IwRFvgZbWKj47VUUtaKPiMx+pdyBRjtjTCuvR6kO
 KZkmmGzqH6Fz3TnwJ1oyN2hG8T5FbgZZJfWCNifKBOO3pQ3oDs+GqWUyKGknQdGwbyWMUc3n3Ai
 DasKEh1CLcr7w08CYs1Qr0yoUzCeDJ2Hq3uu9lpGmLnripmk7GN+ZCapdFFwjgtnCLhGEGYheXc
 wcsGBrXXpVi2xBM14y4hBy0+xzQfBjz8mUSM2O4Qn1NYlmGMP8Rguh0Z+yroesEheVCjNygRM3c
 EOqK/MQq9joZdd4lNY3sjoHtAel75YhW5hMUCk3hKNV4Hib3PfyGBX6LtqbjIaDwvKhnb1NEGki
 CKdvI2aAaCgHX89BwRRBPDWj2Ydq83R17bMGNb2C0z0paNcIrLbSw+60DgozJXOiGIBIvF+eM0k
 z0lAFkUnVD3ALdAvPxqQI9WpmaOnI2Wg==
X-Received: by 2002:a05:620a:1a20:b0:93e:acdd:acd9 with SMTP id
 af79cd13be357-940ef7d38a7mr1789367585a.7.1793129106126; 
 Tue, 27 Oct 2026 12:25:06 -0700 (PDT)
X-Received: by 2002:a05:620a:1a20:b0:93e:acdd:acd9 with SMTP id
 af79cd13be357-940ef7d38a7mr1789363685a.7.1793129105671; 
 Tue, 27 Oct 2026 12:25:05 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a952b0418esm2105775e9.11.2026.10.27.12.25.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/59] hw/arm/mcimx7d-sabre: Have 2 CPUs and 2 GiB of RAM by
 default
Date: Tue, 27 Oct 2026 20:22:53 +0100
Message-ID: <20261027192341.9197-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P96GwJ6ppcomGz3hdeBQ9F2jUedzUd9u
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae0fa92 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=TiZ8CxiaEXEXIp79E_cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXwK2FDijo1hwT
 pM9HmHyMMwl/A1KP2gqmgXbTzZbGIgysmBRmnjhzXDu61f7N4L1bX1OePUCVUHWI8GQbWBIvq9M
 c+6D730jcMdoJBbVVRl4zBoJAsS89Zo=
X-Proofpoint-GUID: P96GwJ6ppcomGz3hdeBQ9F2jUedzUd9u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXxZbislAmNvjq
 LrvfIr+g+lCzXdqDHUHZNP8PAsgYe5FoYJ2DjR68mDGpPU19kOSp66QMJ/sxdZds2hbE5Hs/qhp
 ZrvP10/bQUPe8cUOFeEN8vBQwmYM1zoqNW4ZQlGcgkmrROHjQvzIU7fPW5JE5+uU+68TIjMypqD
 t7JpUrXorfVTSuk9osrfEnI5TSTkuECdB1fybNYG0Xwld+xYJMqeqRFCFH+ixVyjbiAnxPw5yCt
 JG1Af5nHygKVa5t9++yE4UXF5dTBJ9W8+8J8d2BJNQcdcfp5pLF11leJ6g8EpP+aZmkiCkVDQ4g
 jrPei4+hxexBABbkTUF/E98N4zyAy/YWpu0g0PXk1SFcM24jUh2MFrNeBceQVOjJ2UR/oropyYU
 FWQo7ywF3Wq7G5/RQhm3Z/ykN0PyOM1HLBlc46UkylOKAwilUQVfNULDsS9dY7SOqJhGy5FsiKl
 uAg0CKo6fja+W8vrXuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

Having two CPUs and 1 GiB of RAM matches real hardware. Fix the machine
defaults to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-smp 1 -m 128M` needs to be passed on the command line.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261006083445.30362-11-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/mcimx7d-sabre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 65fdb19c06fa..47744e66a4a7 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -81,6 +81,8 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX7 DUAL SABRE (Cortex-A7)";
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_cpus = FSL_IMX7_NUM_CPUS;
+    mc->default_ram_size = 2 * GiB;
     mc->default_ram_id = "mcimx7d-sabre.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.55.0


