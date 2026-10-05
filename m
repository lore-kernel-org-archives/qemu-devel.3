Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF1ACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDnrZ-00005N-Sv; Mon, 05 Oct 2026 14:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqk-0007fH-7n
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDnqi-0005oJ-Ke
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 14:55:45 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HLKIV2909376
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 18:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kdWaoa0aY6i93HypAGh1o0ui7ouEvpMZy1zAuWNsp1U=; b=Poxqq6JU890s+mrd
 rq80KpDN7usJBBbzx+XjGh+R9d0ioUBipSXUSZvSb+p2CLltrwFIxnZQxZQycHu/
 ICWyI0qylHqM2VoSTD0RFCkC7yO399mMOA3M9oXj8TBnFKPhP7Hqz22ECFjndr6h
 j8cRI2geNdHsXNjf8JrPtgfaHNGdjzZSULm2MjOo3/OorofiLPDqLT7UPmsBh/hJ
 NTbRHaREAR0lZmueraeSpiB+zlZWU1MUqVhrHUlWSmjZZxTwg5JoBTZMd9Ne9FXx
 DCKrGeDf4PpIx6yOcySiRB8XCeXv0/hRPkUFwzs1rRO6tYzx8/tULmWUxb1us4JO
 DhcDdA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg1pxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 18:55:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso6198269eec.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 11:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791226533; x=1791831333; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kdWaoa0aY6i93HypAGh1o0ui7ouEvpMZy1zAuWNsp1U=;
 b=SKtBWufxjCnD2pdueUDw1+OwOZQfK2k9Awnlwn8o3S17Nsh2EsQkZ3wCmufI66HJt2
 vnIbmfcMJTPFlnOrEmUltbvYQ2sGDisqEL719+aBHxWPw3zL/qGdm3x+AvtUxtZ3dWnZ
 aMin9xeYBE4KZR+EVvrVFaqeHtQf9kAYCU+zvBWbpKPtBecKd3D5aaCQxmMQY7jUEuFw
 s7I6NwIoRkjHULOwG/HGtbWRM8Wpb7/EaaZ6zFnmjAZjkbFpdd/QKfBOiDbJ8gXpK3E2
 8nPasmUN5KD3Jr0hgtP9EH8Ss0MMTZct4HsQAhZASGFTxG5EX8t0W+O/z/NGHCV20e32
 WXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791226533; x=1791831333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kdWaoa0aY6i93HypAGh1o0ui7ouEvpMZy1zAuWNsp1U=;
 b=vXLWk+fefYdy7MdOa+by8HEORvsi0NJR1ISH3i0qaLhSCnz1uEH4nCvQ/SzChLu1H8
 JjnX1yt1p8LILVPgAmi9olaHJGDB3CJ4BXaV3FWjPSTv2Y5zllJ6fvLxyu2xGWHgft+2
 boxEWJD1cRReGyjEEcBdiVbF/1oMJbOQ8hYF7zYRYXSsDNFeTzEoMk4A/vGwoQ1Za5lj
 eG03caOzLLI8xA3WNYDNY4zJBYKODlcmgTS9pWIq3jUctQzliUmtDfYRKlEhb7U8J07a
 CbMtAnrOqJjJ9aa7+ZKtuAo7qptEd1tnp5P7xLeH+407GLn1l+3F9rkXsXDkznpJ6fZH
 g/Lw==
X-Gm-Message-State: AFuF++k/vQVksAweQ70TvUNdeVOaIzqjSjZrA7UZmoaPcvna2cQz6rpw
 unmhKV+qRV8gNF2bbKcIAyat8lhlSlfXfMF4EXMnSD19pOG0eLVpLeXguZooQTjkyFuWsH9IWD7
 WjEKRw+yUa0A8Bf5XfkeMsWBTlyNeb7Fphuqe7QWWuxRnbBJNvItaTSay5xmEXf95mw==
X-Gm-Gg: AYBFou0tPWUUA0XLyviNTP+2xY0H7NBZk1yIyWikaa7IIH2kbg7BgfsJ8YwMGrTq8I7
 uwyjViqUHM6rWHpxVbRLVqE/KC7kSCQ+T2dgQ2VijVS7zvQx5W6WI2aPiskAfV4893N2w2LU2eA
 +qbJup/3ti8M3A7OreQPZgc0XzBW59k82plNKbPpsDowtTRS8TCGnKvAROLYika4YRCZDB1taSd
 1iCwBt6BC1VQrgys0GiyAK4x1MrEhFmkQ8UvFcY6aQdLdaeHy+BbIMsehMYYTPjodZ3wHUS2BaX
 DO9RL0B4Zq7ydBm/uFq1ZznOVhdxvxkFYNBiL3ncXiYiJWNoOUbBbUQRS8QF5cfS4vht7DDxrYg
 YnmLBg/5/3CSL4UOEN74hcAY5FJExl+IQcqzUO3tP1IU4LrbuxDKLfEMqPHFY
X-Received: by 2002:a05:701b:2093:10b0:144:c12b:4e35 with SMTP id
 a92af1059eb24-14f5d4b29e6mr14973294c88.42.1791226532627; 
 Mon, 05 Oct 2026 11:55:32 -0700 (PDT)
X-Received: by 2002:a05:701b:2093:10b0:144:c12b:4e35 with SMTP id
 a92af1059eb24-14f5d4b29e6mr14973257c88.42.1791226532027; 
 Mon, 05 Oct 2026 11:55:32 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-15d7234c2a2sm602092c88.0.2026.10.05.11.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:55:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 15/22] meson.build: add rx-softmmu to multi-target
Date: Mon,  5 Oct 2026 11:54:51 -0700
Message-ID: <20261005185458.405929-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261005185458.405929-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: g3AEvS3gBwp1pLxnWeG8y2vU3ddnRxfQ
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac3f2a5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=ORgI8T0eWTKedyQ7sHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX/GrOFMWoasIH
 6ADuko6/ynCdjSpM7zpVrLOXvrnCY3OBL060vH+0ugOHt3QysG3U/mTDh5FM+SGG2qI7gsx2fWu
 VymNGr1t4u2MP5W/AQPb9i79mPGnDrU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA3NCBTYWx0ZWRfX5gCkSzpLw6P1
 pGAdUzD0hVsDelJam+PiI/Xo3CIN5GdcUiSRIiVyFWqplFoXRf0JkV1yLfUfyWooWr0tDgkLUVT
 6iWF6LbLfp0vJChQsil8uKuVRooylB/uBDTyR1u6pQPdvj4xzL/2XfPERbksJQHQ/QBSSJdbaNm
 wkdovDZg/I7VZxhe3W1uhsWYHiSNjhHOrdIIYc1n7hBXIvocIO9EP5vtWGYsz9LF8g08j6oXHas
 ARKhgd7CDQhCsJw+U47a722UMZpakdb/D8gJrq2+f+1iSMaLx1vzt//2Ik2dRxGMHaoWsRbkG/t
 5I0On04bbaqjTV+lD9sr3ZPqfOeSxcWO4xK7nN/wnxXPmqsPIwvEBdyYx+VWULRtAMfn7F3N79S
 tTnEsngyimyOTg4WSc3NVX89k6A0Rcb+vCgYrCZRi7eKw7y1ncwhoOu1czjBDbjNTXbCU267uBL
 rLPPtUZY1+elknfxxtw==
X-Proofpoint-GUID: g3AEvS3gBwp1pLxnWeG8y2vU3ddnRxfQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260930020108.217892-16-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 599466f922d..487a5d6f7be 100644
--- a/meson.build
+++ b/meson.build
@@ -4269,6 +4269,7 @@ multi_target_supported_targets = [
   'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
+  'rx-softmmu',
 ]
 
 emulators = {}
-- 
2.47.3


