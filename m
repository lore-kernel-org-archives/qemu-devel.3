Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22C8CA5FB3
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBje1-0007aK-UP; Tue, 29 Sep 2026 22:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje0-0007Zz-NN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdz-00036v-7r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNPgJW2969038
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZkNZ52c3sct
 KlvWbYBNPVAkJr629OAE86ziNsmLdwFU=; b=n3oNIn8844PH2++XZIq/WOTfLOj
 k+DbQv7yEN87r3ikSHff0unG5H3uzNG9TSEKO5trOyq1HhIERYMvfNXmfNIu69qF
 2Fwp6bB+LogcLioKh2Jq3MJddqfTwzv+tJa8k5HeON90D+5UklFps4BgU8vKJpFm
 AAQ8KV3j6crajcwiesb7TuKRBVsDP74vW1JwCmy+q1qhAcXIc2tTgf+B/XwbbkGh
 C95qcxE7Cb6PC+aNRTVbsYYaIKhCmY5SUEk14gEh7uWo0+8R7mDS8q06/QMZww+7
 yAs6YXbaWuMrpVgXFEvBwKSHk82njqLQJXbGsM+WTdR3XVo3AFPvtlv8fPQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfa8ymk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34316295d86so8418454eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733721; x=1791338521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZkNZ52c3sctKlvWbYBNPVAkJr629OAE86ziNsmLdwFU=;
 b=BFYDcOVU57kHdrEEEaJgj3g5zp7veA5/ih1k+jGkkMmrB4Fo/Wg4SFfXnsAs/aYZwK
 ItGS5m3qcLd8XBgXUn761q1st1qwacrokCed1eHk3ivyBn4qPxs926anw2r93b2B4UMv
 rksJh9MqH1fAV6wTlqajdLBPD1LO5DDGrFZN3YUaxsjeHFTm6YsJ00Ew99AiCQQi3vL1
 ouSrrzqBhVVdxqzNOOr5TRmX46cxhWgqcviOZm/Ju7po4G1Hcs1tnxcOEBrOTHJqcVTY
 fqXMA2PnFz/5Eiy6twtOHjXKNr1wFMArpZ/9OBoAATf97/GVW6phBhZV+z/ApDFBMSnY
 OCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733721; x=1791338521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZkNZ52c3sctKlvWbYBNPVAkJr629OAE86ziNsmLdwFU=;
 b=pmeivyCfYAhdEjCgstHVnOJWfuLCcqXsINH99vtBwTayWHtJyZMJcnH8+YfvBZcUiY
 XOOZe4Ibst3uWEqjKszrGHmO7Ql//qb8uzWY4KtHbt1eyG1PchMTRfPcH+xGZaHW9QjN
 H1cbBkbRh98CCRicfFDsWBuhflzzc9QLAjcEXHajVli7FIF3XX2ZuVkJdv4tFuVdiJcb
 nIt+J7WEa+/fK6k/nlCJihAPlOwoXoNQ+XcEwYP93x99hOgxDKd/gvcu0yAlEVaCexXe
 wjGqOJVEOPS1pfmP3RY5gViRL4sqfohNs7Tui/8NXpxgInRBeiwtdxi81ytAvAMdgKW4
 i87Q==
X-Gm-Message-State: AFuF++kBGmLn2893Q2oMp5aCyoCVMWygZO+/wg4UESVIlQxA3m8dI5kT
 0kvGKWamuAxNGvtlvlrJJ3E4uAwkuuCmBVYSKTN6vrEiuGk5pupqzv8OPYDT3wjYrlKm7WEz0n6
 JIJaIuDmHfSKREFSzvOC2Alu8I9OnHmqHzxw+Rbgr80ZlRpudjrF/o/eV0P/T8TMiCQ==
X-Gm-Gg: AYBFou0v+CdvwUElv2M9IweYe0O46UM6+s+XxqdvptwNc51Ats26Pzm81+d9j/rA+fb
 nVlOqCitNbnm7AVxp4K1PsfInsrgA46Q4xwtyNlwwqGixvBnZwEdICdmxf4HmrQi57F/1sGdP4x
 w7UlTD4uI74haOGoXpkGDn1+mTAQcXkhDtoOh85/UC0M5MZpgXhsecnRm526nCd2ncMwxHdLE44
 g9+RkG5tI8zzzOnD6YttNo+VlzU5PvxR+kp3serS2IPTiQ2P4CihoVR+F2SnlWaRdKjAxdVt8Jz
 ZousjnOgtJoiXeYtfypPuRHZI7xgXXbJitMJ/i3wvRf20lHukc3zkWWRTqrI5CdPL2ipFbzyyiw
 9s/PygqmbOf43AyFr8sXqMulWve43AE6fY9s/6vAEdkhHfbDlFpOg+cCludvN
X-Received: by 2002:a05:7301:1701:b0:34b:4527:a000 with SMTP id
 5a478bee46e88-34cd91735dfmr152817eec.1.1790733721125; 
 Tue, 29 Sep 2026 19:02:01 -0700 (PDT)
X-Received: by 2002:a05:7301:1701:b0:34b:4527:a000 with SMTP id
 5a478bee46e88-34cd91735dfmr152787eec.1.1790733720587; 
 Tue, 29 Sep 2026 19:02:00 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 15/21] meson.build: add rx-softmmu to multi-target
Date: Wed, 30 Sep 2026 02:01:02 +0000
Message-ID: <20260930020108.217892-16-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX4CZbE86DZiVD
 xdPOQ8PZi4emumG+yVhjY7tFEqQjx06ppYLWWzFdTqL7VcOumMRwozg0twFKCnnA3nPJFfI61UK
 5DKL5blwIZuOeRUF6bSC8wmUTkBJhDiz2HYj5PYx69gth71e/ksuuSYFeexy2Ab02MKqMiffQrB
 +ypq4VbHvyjDKF9x8qj059gxMBVVPOko/F4/WYWC3MhYvqZzjRBwp4cVTJpXMV0uYe+PVU1PoQt
 BdaxiqnWji25sKZHJmxEMBEIvGfi3gfR5lK2V5UaHKFdrgsqPohMVhS7B/eSKul8gbhKi1RvTnJ
 5+2pOhU1+MvdBrhYWEVPga7uxJDk6BwNr8FzMyidJ0V03muu9AsfDdv9S438CwYePEXxffqIP4t
 afpmRblmj/PIoQE0aM+jGoAmJtWQQglyzCkpz+ppj1IERbzYvITDcbUtEhgvLGKbE6TujRza3Xh
 OcYMQqzE6/BMucm1Y2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXxPQ+MqdlUFIJ
 elEFczyBEr5D7OE9y1iJsPE376BvLfsbW2pkqVdsF3tje84CUguDATwG35haUlzdLstSNXs6noJ
 UILfx8edRY3MhznK6FXVs4ski0Xhe0E=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abc6d99 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=rGndRDKaVEgXTp5yv0IA:9 a=Dcm0jervGpIA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: fZeTCvudezT-bwV_SKuKPG7oxHtNLYWh
X-Proofpoint-ORIG-GUID: fZeTCvudezT-bwV_SKuKPG7oxHtNLYWh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
2.43.0


