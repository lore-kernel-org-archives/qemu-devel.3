Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC19EFD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Arv-0000lg-MH; Wed, 11 Mar 2026 00:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arn-0000kd-1O
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arj-0008SA-5v
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3Ewic248694
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l+1ljzEzP5x/CpA6C2C79uaz/rBvlTsDxidicaD749M=; b=jztGzT/VNfMCLiWU
 3lgCQRvg9dgwRR5qtm0W7SY2jtiouqSX1idPr/EMNS9Rn04UjuFL4Y2Xnj/aMqGc
 gyN4xrsQhoPC1ck0ddsdL4nGFrfzquVH6VxTRftE3EubeuCHn1uY2L4TUg1W8zDD
 KweQck8L6sLc2D0/mJupUoceb0HqcevU+e2BHreNs5Xqd0vjEqtFNh+YOrn9l9LV
 +iBkJFk+3FNhiPTNagBfg2ml9yiVGfXfY3IipZIci0wFtWbK3urZHiokCRNhCHr1
 X+i3jNYOkT6SjGT9itGlPXmMjECu/5ylIyi3PMXsvFD5/8BRsoRj3QWhFmPPeEIv
 sBqOBA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv11svd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:08 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d74533e53dso24546825a34.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202087; x=1773806887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l+1ljzEzP5x/CpA6C2C79uaz/rBvlTsDxidicaD749M=;
 b=JsaldbgNU6GnHY7u2rHbv7gzGydo3leOijVjUzpRU123LOD/wB2lUNmHtqCzOJZTPN
 +0liQGSLduvMUnq5F3b1v3W2LBtgpUGXPyciYAbGjGssxeSYiFyrCZNRcyhkoRgMwHoR
 w1inPBlUm+HFU9XKf5mOfp6I658/NSeRomgev2I61HfYU4kLcPJFZV+IanIi6HRErvbq
 lS6ZLGSr/iPoqZJgDmB91x113BpgtRc4ddQi0TjHR/XQGHve2luG/hjpigeQpbO5EOEe
 GEnQksLEXm0OWso/NJb1oyRgjLSXc12XnB/3mxZ1hRoAQ41APfw+8MCFKKMvjm1zlfF6
 Jkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202087; x=1773806887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l+1ljzEzP5x/CpA6C2C79uaz/rBvlTsDxidicaD749M=;
 b=i59nwfomW+ot4QqJJeo+AL1zoegnKF74x7LBWoohbkcTSyDmQlYkRQ3Qj1Guk9rrqk
 JaucfYnMhXTf0QlgCNkreSjac8BYaYbtV4zYeq55eS9n+QBfa3qzsxeGsIwlP0Fs6SHT
 H2nkjNRjBbZTA7NLDjXOgnuvxrU+rP2hnBmNAr8p5w3W+lYLwBp3+DFeOtZb1AV1Ij+y
 Hc7CwVWlpZTy3Pgh4VRm23czpEG0vSDCeMYHeIKaye+SCrtpWZ0MxgKTmyQnjRrV6NAv
 l0ZDXRjxgLOiei23uLNF5HPiHfRGpF2ms+rsBrhgZ6hLp9ExT5cv2JikuUMuP0qkQ8v2
 J/Vg==
X-Gm-Message-State: AOJu0Ywe+AYef94cMHhRd+zsR95cEWNG3kfHXbMhEDwMkEknCuldgh2n
 i5IyTRbDxik9qs92oGR6Jyarnt91rJihCNk2tllgWGllxDwUcgIFXpZ4Tkn7aWAGOHp/xgO0Waq
 fhK/4iwnF+g3nq5c18YMhkqhKmpZJXM80B1aje8cd9K6PLJVmsC4VR8GWQz/zPaWPzQ==
X-Gm-Gg: ATEYQzw6BignYO1PvdiKthQGu5Dyx1C5QlOlBmby7xKi58OHy3YoYCC7lQubgllPH7w
 EAuNrRIk0vs1egYyztgD0I2o3r6lfguBmnPO5u/9/B6AEvDTbNaUWjk9IwuMl24tBNATRLbbJUL
 8OhQrvRYk46U3vqUou92t7bfFMzufO1GAFN783bBkl/wi/zKsyu3UryT+p4jP+kUmF6t5JY1Vqc
 XiKDf7bgETosqFHKDrtLxPqllwRT64S1iW6BCEZ9+tJ1cIrat890dUmBrSsL/HgW4rW3XMlTHoY
 BNc/RFRv1HaInYjqFQGCQGdCPFB5x5MyMMgpx1WPIgi1ifrmc9NKdtR+AIYs/wXjyAjAI51XtxF
 qKwfdyv/rVq2gThYoE8f4E4gwCoDuZrqsw7Y13A+p//yYsvwZ2XiMp+SaRfternhiNqQDCw==
X-Received: by 2002:a05:6830:6af6:b0:7d7:4d95:23bd with SMTP id
 46e09a7af769-7d76a92be82mr1080541a34.34.1773202087405; 
 Tue, 10 Mar 2026 21:08:07 -0700 (PDT)
X-Received: by 2002:a05:6830:6af6:b0:7d7:4d95:23bd with SMTP id
 46e09a7af769-7d76a92be82mr1080524a34.34.1773202087063; 
 Tue, 10 Mar 2026 21:08:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 01/32] target/hexagon: Implement {c,}swi helpers
Date: Tue, 10 Mar 2026 21:07:27 -0700
Message-Id: <20260311040758.1068731-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX3q5W5rNO1djf
 cd1hoVeEvJAIFhjeg+PkaDG2Q4N4jpbUhR3UpI+QblXU1f2S3dq1Cf3EAPRoxfL+axL+lmYcAjq
 GIl62FNjvVnshevuSDmDrU9k7wWFBoJOpe2nHdlhljvVNlnXnXADWmRvjD7Dmjh0RFgqJIndP0Q
 /IltmBKSeoPbJOu8+V3RqbNHQhRnwlZVTmOo2LvudlVN1LRAMtTLjYIxoNsw78ZUyhU0cjYRdOE
 18nYO1syXukKXV1Y3EIh/lJZUONEiIBZodMFW2p0lgyvqi4bQA2GlddatTj2h7GAMaRYnXIsrvk
 l9+k8SFuHZPD+3S2qhkQBGLzdnNQBqJy05VJoTFzbKEI/MrGFV89zjMRGRwfvgi3tt9Fta7IWKk
 sRv+LF1cEN9f51z2aN9rqPAB/p2Y1GnQ+oopEg/lcvDiqGPYXP0IPODRSUPXik0hGfKN+GRrmXc
 qM2Na6216gnyQ1gMmKA==
X-Proofpoint-GUID: sVayK8HFJTkHwU2A0nSMzzLim9bd4lcz
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0eaa8 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sVayK8HFJTkHwU2A0nSMzzLim9bd4lcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
MzUxN2YzNzY4ZmQuLjcxMjYzOGRlZmNmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjMsNiArMjMsNyBA
QAogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5j
bHVkZSAiZnB1L3NvZnRmbG9hdC5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAibWFjcm9zLmgiCiAjaW5jbHVkZSAic3lz
X21hY3Jvcy5oIgpAQCAtMzUsNiArMzYsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNp
bmNsdWRlICJ0cmFuc2xhdGUuaCIKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4c3dpLmgiCiAjZW5kaWYKIApAQCAtMTQw
MiwxMiArMTQwNCwxNCBAQCB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CiB9CiAKIHZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY2xlYXJfaW50ZXJydXB0cyhlbnYsIG1hc2ssIENQVV9J
TlRFUlJVUFRfU1dJKTsKIH0KIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBzcmMpCi0tIAoyLjM0LjEKCg==

