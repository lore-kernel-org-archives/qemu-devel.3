Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8693FD88EB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Aa4-0001f1-QQ; Tue, 10 Mar 2026 23:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZm-0001aG-0d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AZj-0005Bv-La
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AJvdZf3296538
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eaPTK8WsZS63Nq3x835Dlm5fZEwFXHAh0ADELEtS9L4=; b=f92jp1eFSJUhrsmV
 mb7VlV0YivOL1yZO2aFHTm5Zg9m1RcJ1UikucuSLsEJhjuVo75OJ8Z5WvLBK1QI1
 XnTz1024AoB5MlB3fhgAknOm019g1PP2NkHmNOJMZ2ookpFp5/1peghQD+BkNn7R
 OgA5ZxliKQLvPFdssLR25/fV5Y0B/2OfKXkln1mt+OfT96ahdoZcCu9Blb8Ina6P
 ReHAlfcNqRZVGATuvWv+MyGWvQLI7h3446+ngqxFif6LTYYHIpx9+92mXjFNpF1c
 tI4Jks6kbaI9ho4n//owBq6p/ix0jVC4WJB9exaXCERNxUM2A+4J/VIAw2H0H5BU
 xWXJkg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg1muuv0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:34 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d73fc43561so27811698a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200974; x=1773805774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaPTK8WsZS63Nq3x835Dlm5fZEwFXHAh0ADELEtS9L4=;
 b=HXsE+5I6MBMFs+81yB5pJbhL0/j6CTLUccm90LuK2jdZ02rfrtlou7DP1Ja4rFBync
 LiaQM7SDFVwA7kXz6RpzgmSpM86FXTEqYCk/AX0PZVujdgGi0plCwzBFdWq99+W/q77Y
 uLZSukgHtnSw4AchTjDzMYjIFFmK/syA/QT09XZbVtgGDLlYbSmbGgnXbnhwFu4+UxFc
 Q3EPdP9BvV+F8ct4jvRSq4p5KQs6RvL5zQNzJWsSgXLW3jpw+gkAcxC/By8rGsdE3Jnn
 qJHSf6N4984WQFf9FzUfTDq/SWPGCexBQPCyuGnFoGjBMHf5E96+KIh+YwDN0HQ65Ppp
 CP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200974; x=1773805774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eaPTK8WsZS63Nq3x835Dlm5fZEwFXHAh0ADELEtS9L4=;
 b=HakUKkQYya70MO16nPoJKqYSFAohuvHUaD+tLVU+xHUR33a4sslS8oMeoLBU2Js6V5
 QrIf2GSYi0oTj0DGQX14oYc4c2SARQPgreUqS9hn1PCUK/Wh9pjya28L6MRd3ZzR/NzD
 /E3xfGTbZ5UxWAgy8pfo5lZa9P1aLwxAMewNp19HsfchYq4vpIjULPCik/H7Bn47z9m2
 s1D6i31ifjc+ZfRaCefUz2i/iR61ZLYO2C1M/2OWzxKQcaUafVert8ZfeJm1kDtzVFqt
 ywFsgeWjh4TloNoC5/VGSG2H6OH/ML8NZiWelz2IX2in0cUA+hyBPAUgPg5k9WSicc63
 +k1Q==
X-Gm-Message-State: AOJu0Yy851kHOXjwOuXIj8xQJ3GuO0IxlJ4u+/vInsldAH58m/fY5sYG
 ex1/koycMbOPikjUx/NWYoUVjCb0BsSi6pBUHTgzSPF+rHLZodyTpo4bItsmaJwbd7T0VWwNX7A
 FzmFKMjyYD+MvzgGmu1JGUWf/rJ/ml8Hhpxuw6SxbJTXl3gzC1GWgwOaliFi8+yqwUg==
X-Gm-Gg: ATEYQzx5/ejn5cbF0YlCOI45zhfwoi4k7hipbBE9YXykW6hZvwyW5i20AQWiav0zEdE
 G/c/QPJI/tC3+SrXqh9d+acZ6lWgt2F+ZmRH2TVWdh6UNwy1Gu9WSN3p5vhfdDM9NwwkV9CXcQC
 vkdhLYXTxLMG2n6H8yZXZvZOtDZtA46CXsrg64nzQNu0tpm+haW+NgFut1DNfPnQZuIB96cvjCM
 CUXsfYU3PchJjDeJzOj3d5t2m0s9QadIVnedzaeX2E/2zR4qZUN+/k+ibecIijOAqAd1KJ/Hn4o
 +4370U8J04BhjZUaV8Gp4LRC/NQ0/15RummbH+cyd7HCz7plysGlrk2jF+l/r5D9fcsyxMHza7o
 eABQYCVL8mfrU1sTTDiFrPl02eSNmgK3lwcrDKYEkntwiFvTaQJ69VXBLRlJ8uGnK8BfrNg==
X-Received: by 2002:a05:6830:6582:b0:7d7:3b11:467f with SMTP id
 46e09a7af769-7d76a75ea16mr1072240a34.32.1773200973874; 
 Tue, 10 Mar 2026 20:49:33 -0700 (PDT)
X-Received: by 2002:a05:6830:6582:b0:7d7:3b11:467f with SMTP id
 46e09a7af769-7d76a75ea16mr1072221a34.32.1773200973519; 
 Tue, 10 Mar 2026 20:49:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 04/35] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Tue, 10 Mar 2026 20:48:52 -0700
Message-Id: <20260311034923.1044737-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=YOeSCBGx c=1 sm=1 tr=0 ts=69b0e64e cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=QFI6e2jESK29WoJ26_YA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: mJgiDv9MuAdaEFM3TEXew3hoFT-AWaqG
X-Proofpoint-GUID: mJgiDv9MuAdaEFM3TEXew3hoFT-AWaqG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfX26AUFdImZRyw
 oWuADERQUPYP9vIQGpk74lJdO60sMuDHXetXkPQ3A1qSHTbEO0NRBu1u7uElStU19QzgyEEAz1A
 wIekVk1IiBHsGRJ96qWykZIH79lOfLThHbcTPknyEuGKwWMJfjiOcXTrIZ69DYNp+L69eTBZEvP
 TNKiqI4jq+3FcyvnWzM+RThkUIY+Kc6/vAJILc+K1IDQHgGGYMGxVtZzNyfXr34XRR+tc37lNSa
 yCpV+wW0dquboeBgza6/qBWcoedNSdpShIWj/pdiVD2plr/MkiNoRuwom/nbOhyEi81pCdslvHY
 4ByBB6y1ZAkTK9meAyL/GxkXWwdF5U+BjY4qjcvv1TXUTKkzmNrYpliTdund2jFL6NV25ujTC6m
 sYAp1eNlmU/YEbVnOTf9fJTICSL6xg0IPzhOiikDxecYhUd8Oh45VCdA6Ve+zIL7SfGAaeOLQ/T
 N13EqaWRv/DZ3MQY1IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5IHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBi
L3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5kZXggYzBlOWYyNmFlYmUuLjAwMmFmY2Ri
OWUzIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI0Nyw3ICsyNDcsOSBAQCBkZWYgbmVlZF9uZXh0
X1BDKHRhZyk6CiAKIAogZGVmIG5lZWRfcGt0X2hhc19tdWx0aV9jb2YodGFnKToKLSAgICByZXR1
cm4gIkFfQ09GIiBpbiBhdHRyaWJkaWN0W3RhZ10KKyAgICBpZiBhdHRyaWJkaWN0W3RhZ10gJiB7
IkFfSlVNUCIsICJBX0NBTEwifToKKyAgICAgICAgcmV0dXJuIHRhZyAhPSAiSjRfaGludGp1bXBy
IgorICAgIHJldHVybiBGYWxzZQogCiAKIGRlZiBuZWVkX3BrdF9uZWVkX2NvbW1pdCh0YWcpOgot
LSAKMi4zNC4xCgo=

