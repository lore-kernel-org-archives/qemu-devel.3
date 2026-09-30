Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A09CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdy-0007ZZ-PU; Tue, 29 Sep 2026 22:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdx-0007XZ-4t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdv-00036b-L2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQKJw2010202
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9cx1c0SP3jF
 ZGaJG8dpeUPUiLOVCYXsl2/TCpCFV1dI=; b=Lv7Qn7jpJR1Mwirl/klMw+mn0Jv
 vGMt0LTxKpnX/9eGWXHyUdPy/T6EOK6xpZ+FUdM7hYVJmdvQr6K5XU8gJOY6UzA7
 iGZMvnjQhGWaND5fUQniE/CUoeQwJ5c6ovkDi6r24yVd0vPPrebyrgaWgYI/y6Gt
 PaqPkb2+Vl5phOHrHgKrBXwc4jm3Oqw8mQ9tNB0XipFC/aWI+s5WRBFKGwaUBYYH
 QbqicEFO4/ats2WbPjMbOESOEalodW5oHcS0KW5/bt3DfICo404GQu0B4kT4F+7c
 m+Kb5ZhGkP7mPiDtYjJ2CRokWvGuUUZcQxFnn8lMlp5T1Sn5Ghebq1JeI2g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0ftujdpq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:58 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33baaba6371so18192520eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733718; x=1791338518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9cx1c0SP3jFZGaJG8dpeUPUiLOVCYXsl2/TCpCFV1dI=;
 b=flMP+MuuhMjrCJyhY+DGtc2yPEtY9NaJexmxJD1ndtkqxsZsciPC/0tKykblOjvt4U
 6H4MygIJmkGEPF4PT8mj5yoFw0O5XwPli75ASd7iBU1BZbg41Fortveq1nXf1Nx5k/me
 wXA3a6is+vH28qmNgBdIbuCHg8rh96vR37M2ed4VnwWuaGPkHJ/Jzd7UfuIQP2VYk2m7
 P/2bXJqTRWKRNCOA6emZgQ/lxo8P1pOJENbksf0YymEl3cx6y5mvkpE1DRZEyVSKjLr0
 pab6XhZlA0YWec1QQ3yEPmPg3A1drX1v4AUdSkeAnWJhnb0xcz10IuAexu/7SxHLUQqj
 dXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733718; x=1791338518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9cx1c0SP3jFZGaJG8dpeUPUiLOVCYXsl2/TCpCFV1dI=;
 b=ONYUf8uq8s4Z7WZUTebhHMhMR0l4HsTg1x7PjQcixFPfvuy3KmoyvWIr45j+iNEJil
 WW7Rq5aqhSE4ymWs+IXEmmEMA1cFFOkFEtDMjO2WumvzkdA4dzjsXCx30UoDsdYbekie
 ug8NpUtGxxAcQi9/CXnDbK+sWEvTmy0hwM96iIwiZaJU8DbeqovueNrULvVxGUgT4OLt
 d1fjblgYgOSPFfnHF9vG27IL+uuOctRcaOdNCiapmJS13XRYogkj30lvxeKHIb9CIZlz
 tUJgkQC2YxwIRu6pYGTDWx8utupFGThOWP5Yp13hDilVoXdnRvhi6ohPhrH9mGdMyTfO
 kB3g==
X-Gm-Message-State: AFq9FYIFFJSYy1GJHXXPIZ4t1RIh1l2OORaqoPohQ2jfyMzdX7Bi5532
 uoIZUgTRRjRKPSPk2YboLGFXtS2mmMOW0W+f4XAPG8VlFSbfEGjUuuYk0OAJmutqQDpKKnxdcQp
 Enik5uIvQ2xzJzs3xGj5b9F9YPbfn4rBDHtVE3H4F0SWGr6tgsktQ/IBnsLOAPRCwQA==
X-Gm-Gg: AYBFou1NUuUpwgcqSbnGKrYb9c0Rf+/mPlXuwwFKPScu6T4wh5ZUEFlT8RjHI0xpK3f
 bYBRj/P34+EF2D3iULUWhamdG1xUfL9lj0WGnoA0jiYgDVSOod9Y3TX991LVY90+AKE2ebtVQuX
 z4etEr/K2Jqdz46yl4Jaq2qMAZ27Eq+2c8qWD30RxnnrsdWs4dNxVTrqhr6ezdtg8amdFdgxarv
 FTEmwwenIgi8wiB/kgLCTKdB+yoJdJ5vmkYQxrTHbUmrCHwowoQqHXyA9jOR3LFDSw6O3qpYnPt
 IPcXsbsm4BlMnZCBjdAuzBFfoBE+B4/QYvgmMCjjyPnsQPA1ihub6AoRzdPSSVnKuTw/iCC48el
 kawJJSgo+PjN6d3zJjf8UkTBoACCPfh3BBXZk31kpMVUqKoN+3Y9LYThgbQ2p
X-Received: by 2002:a05:7301:db8c:b0:34c:780a:425e with SMTP id
 5a478bee46e88-34ce0158a2cmr99545eec.19.1790733717633; 
 Tue, 29 Sep 2026 19:01:57 -0700 (PDT)
X-Received: by 2002:a05:7301:db8c:b0:34c:780a:425e with SMTP id
 5a478bee46e88-34ce0158a2cmr99516eec.19.1790733717061; 
 Tue, 29 Sep 2026 19:01:57 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 13/21] meson.build: add hppa-softmmu to multi-target
Date: Wed, 30 Sep 2026 02:01:00 +0000
Message-ID: <20260930020108.217892-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXzq8/ThVTy9Q9
 jCf8by9ekC1gqM08B1O/dcSgxYTx+y1oKGV1GFp93bzHpl8bxBb29Wh5oYAAOnJ7aZan+E0vBdN
 Aj+PEvyPligdgFncLo+vP2i6VMKq3ORv/tPQEG5yWOr9SEDjFNPLK7xtIbthhrvQum0divk6+dx
 eVpUx9+GxF7Txa23hc3fEnpDpk3Rlo0hRxeU0IIjm0Rny6flDeKA51Oa7uC2WbLvM8qKybHE0SB
 Ms/TNBVvfzRMRkHacfaBbjPoxBT/IYB8i7sqIjWT7jStLDCzJtlMxqKoR08bvLSkEYlbq8lHlWd
 QUEIFufWPipUzlykzFyxNx7Shq5ey0u0u/hIJ4TTubzM93c7jtM/IND4gsPdZNixR19ouBEbA6r
 1bb/SKdq7Md5RiwP1JN2Wu2mQH5FGBBcbS0m3fBb+zY9frNQWCtq15ktSm8on+QgWjS4Y9tVoMZ
 eT63LkkcD0fotWrKuyg==
X-Authority-Analysis: v=2.4 cv=AoB7T+9P c=1 sm=1 tr=0 ts=6abc6d96 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=VdlaLvmRXOZORZrBjd8A:9 a=tBGAm_t2VcMA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXzONMrBOZPyyT
 E5Qq3qeBZBdLB+SATof1O6vz3JK0Ti4G+FD/EP4X6ztnTsAO2IkzYpwv6ATQlMFF+P31BeNlFi7
 qc0MEDcjud8ckDjutDyajCFS4spfv5c=
X-Proofpoint-GUID: Hw61L-zD6f-iuWd3PtWkbdSGC0QrWr3G
X-Proofpoint-ORIG-GUID: Hw61L-zD6f-iuWd3PtWkbdSGC0QrWr3G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
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
index 58425a93a93..599466f922d 100644
--- a/meson.build
+++ b/meson.build
@@ -4266,6 +4266,7 @@ multi_target_supported_targets = [
   'alpha-softmmu',
   'arm-softmmu',
   'avr-softmmu',
+  'hppa-softmmu',
   'm68k-softmmu',
   'microblaze-softmmu',
 ]
-- 
2.43.0


