Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91450C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VLk-0003UG-4h; Tue, 15 Sep 2026 11:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6VLd-0003Ta-FN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:45:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6VLb-0000Cv-UF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:45:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFActx813981
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 15:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7BZ35X3MRHZnQ31PuSxL1Ay4xUc5y8jUet3luMY77VY=; b=J0mC0aiKAUud/pSG
 N7dgWbIocmz3j3wgDGVkhd997Z9MZND15aqyepDX2iw3zxqaHHwO2GIKB7Jd+Lpf
 kJVYo0hRonbeq21RugnFeXn7JV7tWKfBECkeRH1ibluKodUktydFCMT06JAYSO7f
 U2Am3keAfg8gN7ldEbRQALS+ZfVTtQK/Bmxx7q+6yAoPbrb+3s84HSSq9j+PuVaj
 kqUD4RrbfKzR2p0hJvBCIeA3CjvWWB/230T4Nd0RAjXh28oC7t1f/RJ8nESfFrdd
 aO9W1X3dLo4PTPQUsbAmyvbwxZdpGzMOIzjSiRSJYvROR4kzc0JGRX/iNIaqImiW
 6wU8Bw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq6kc0w6j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 15:45:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so10679916a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789487126; x=1790091926; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7BZ35X3MRHZnQ31PuSxL1Ay4xUc5y8jUet3luMY77VY=;
 b=DWDlBKVk+7VTpFJLP5qkdxs5bvtdurIebpcLtpogFWNb6AcHhiK+SprzGsT1CzGiJE
 QXeHkmqywfHTKbaWxlJhLjwO4WrXudmm5QBQ7ptqgkp5Obcj54BmFan22aVnckHvN157
 /manXJRxqgwdBkqvQTe2Y/Zzq/KLtefAUjH5JeJ/ilzQ08+3vIOzwLIDbpjTR5dyBw5g
 EO0Cr+o/dg8g8GyXiCUjzS7xtA6ia1pI3U9dlz+/KzatFKmLUlLQWJNvN5tyUROvu7Yg
 tgMC7hV5fNmaBI254gaqMmDcDNzsS1tS8g6CIkdMWFucN/Xx7a6PaL8AQ+I2Fn1lW+7l
 ug8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789487126; x=1790091926;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7BZ35X3MRHZnQ31PuSxL1Ay4xUc5y8jUet3luMY77VY=;
 b=IUfLxzmkxk1l3DqQBVaNucbhncwC9eL61RNHaRdoNulWItSnDx/BcwpUHYiVcorwjs
 9b/alKOge7bOixE2CPSm4+QmqKjFyv5pYz9NHnF1hjkYVjM49TF/gPAoo8SCXo10gWfO
 LrWs9pI9UHWgdXmmI7jxtyD70pvCnCOz0CPWFg8vV8Yu9WqUyUvivO0ptqjhmuFgaK6b
 fWVwfSCap0/qKw5ly9dRa1ytFFZQ1GeR2HGvpzU0gEilPaBDYwyuun7mbWdtnplCP/hm
 titydmJUn5yWxe8KPKp+1aHPhOlInhwuXbTbnErOOmDkeYi0bdQrebQ8az4qcPzZoDTl
 Z85A==
X-Gm-Message-State: AFuF++n91zqPaMwUO0kPQm2gcUgsbhdayfGlMjgcJfUYr4AzBiScrUp3
 Vycm+10hDRiZr2q7slmzeZGMkWzpGppi7ThjN3KFv7VPnuSJknyT5h4fsdaO/78hiqIiJiXOzI6
 6yEQtq64AMGkcj8EQ9K0NvMJ7wXYcY3r+bBVGXG2QNkgRIEsHjZVieOfDEIzNsBvdZw==
X-Gm-Gg: AYBFou0cdRhpDdUPpbgjDoKnR4H3jyB8ShZ3ZDIOyti+hDBngdI17JSjx/kFZ0Uv2rb
 pFt+/N8lkQkCgYTP9bK0eC0t/QEDONz11hgYfp/n9EjhJt+zmSUf9vXArIM8mnlLzpi0EdCBpV4
 qaYFrGxw6jzcqlfI+SzpU+vQ8Xqw0WCslbz2TzImTAfeQJ3TFiKZhZSwoipmeiqjz89vH7FK2Xw
 dO2KQ70Qot3y4/GGyW9zJj60iMn5fYAaka5VcLla9mh5uU+Kyhpt7AK3AgwQTLZXH6Qyh+Aqv0r
 HS2Ul+fC6rObzspf1z+Dirc9ARB9pKF2GxkMYN8ytpsWxMyIjvQGU4U7mEwQZEbDTbe1E8PSLLW
 N15mjKmrhx+X4grN0Gf/2kEVlIZ+jTGPJrktVtmMvkIwkg6on
X-Received: by 2002:a17:902:ce86:b0:2db:5f00:ff52 with SMTP id
 d9443c01a7336-2dd83881f8emr28286965ad.22.1789487125772; 
 Tue, 15 Sep 2026 08:45:25 -0700 (PDT)
X-Received: by 2002:a17:902:ce86:b0:2db:5f00:ff52 with SMTP id
 d9443c01a7336-2dd83881f8emr28283295ad.22.1789487122575; 
 Tue, 15 Sep 2026 08:45:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cca264fsm72388495ad.11.2026.09.15.08.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:45:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 4/4] tests/functional/hexagon: add bestwait systest
Date: Tue, 15 Sep 2026 08:45:02 -0700
Message-Id: <20260915154502.4106597-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915154502.4106597-1-brian.cain@oss.qualcomm.com>
References: <20260915154502.4106597-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzMCBTYWx0ZWRfXwtZXYdWBUlpc
 9suQFj/ooZfR5Oq1sc4y4Ll+K8RzVvWA7wTgU6tcL90Vl/71uG2oBehxcFuHGKp+vQJzjiCqJe6
 sXS0YteY76fls5bqm7Aparrj4aK3fG4=
X-Proofpoint-GUID: rUEfTYLvC9uHQ-40Mrv-PsVjF1W9LowV
X-Authority-Analysis: v=2.4 cv=ZINCCn7b c=1 sm=1 tr=0 ts=6aa96816 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=G6xO-O9Vq6nTrtAJ6VoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: rUEfTYLvC9uHQ-40Mrv-PsVjF1W9LowV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzMCBTYWx0ZWRfX1Cnv12gj/3mS
 7jHvbIBmoGEmGYyMSMkAn/IMnDosx8s0lCiUgymhl4zxWMfGii/jPbDkwLsjGSEk1H1/i5bCwqg
 FvqzWx8hzfdDf97S7v8likxnsxittEcB2w4gLDbTa7orFstG4la2zqoKJS30efXNxX1pAwJW7uH
 C6FLHxLWK4ArFfeG3bJLaJLsz3hozpIs5MtfFTzLRtEzsZdz9L1WBjHM+L6N5tKJife5SBMfMeN
 /iA9FgCRUqGEZ8/wzu5EYUDo1ismDqEbw5mepG/uGRZoEpbmcnP9Ip/TN6NCbgA8+hZvU9EXBO6
 4bJMzb4ezHeofPMVDB7IworKbh+p2kM9Z5TYXeiZ2glCr6BP2TwWoaKvaqRudgtlEVt68gtpjFo
 Sd3d4rJ6w51JW0wvQntDwbh+wW6rfIEYqQucHaH4CPeNRArO3/f+S60AZJlhadgIdb3pgBTcgOy
 7WVPBugdDtBtvR43lFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150230
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5IHwgMyArKysKIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlv
bmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90
ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IDI3NzllZmE5MTcyLi4xNWM2ZDIyYWNmYSAxMDA3NTUKLS0t
IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKKysrIGIvdGVzdHMv
ZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTkzLDYgKzkzLDkgQEAgZGVm
IHRlc3Rfc2VtaWhvc3Qoc2VsZik6CiAgICAgZGVmIHRlc3RfZHRnX2ludGVycnVwdChzZWxmKToK
ICAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJkdGdfaW50ZXJydXB0IikKIAorICAgIGRlZiB0
ZXN0X2Jlc3R3YWl0KHNlbGYpOgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImJlc3R3YWl0
IikKKwogICAgIGRlZiB0ZXN0X21tdV9tdWx0aV90bGIoc2VsZik6CiAgICAgICAgIHNlbGYucnVu
X2V4aXRfemVybygibW11X211bHRpX3RsYiIpCiAKLS0gCjIuMzQuMQoK

