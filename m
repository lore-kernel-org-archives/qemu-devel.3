Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F0FFD88DF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Asc-00013C-Ag; Wed, 11 Mar 2026 00:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsZ-0000yd-14
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AsX-00007a-4j
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:09:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B17M8P508294
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 elIb1JyNNjCVeFtEYY42K/CrYn15CDxzMQe5v8s/VBk=; b=I/GzojM2YYE65/vw
 bpQnEKjJGL0gF04srR6tFacZxz14jAqZxtezccXKthPzeo15Pa66PlX8wN0RRXIO
 FCfwLfleCbztAIHUF7iThUs8N5E0U0dWL1kRf1QCVYF6enib70j9aMQwfUaXnzgW
 VzCKVH+4GHEnHZxMcqRc9tDpUtNgfr6JewNg34GRNOWTSxcDf/50UZbKjQF+ns2D
 0i629e5pWBUq8J2pdjhfrVa8b/7+Bl9AQzDXRwA86qRN9Ha5SPIiY3DoYYKnG2Tc
 3xIHMK1k/CXMIV2MNkUjTXlfltyckYamKguz4zDwxpLptOu8Nixe70S29hYhG3DK
 3/Jdlg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppaj502-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:50 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-46724fd619cso5747370b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202129; x=1773806929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elIb1JyNNjCVeFtEYY42K/CrYn15CDxzMQe5v8s/VBk=;
 b=OXXQtg8+UTtixXzE6TweIhNCo2TRP/VnjmlGvRWfHGQNGiRmPNEHdaOqZC40S/BCqw
 PBxViqc1fteAtpy09+W/DAlnVWGPNieWAlpRGlpfFbsyaZqgbgvHpn5KFEjbSI9tFKUT
 2+xK/5lvyHSYY6/M9p4AsZar/1Ik0cqufTy+XnPPipynxC2nlHpSrz7DcIeW5Rq6/S27
 FQ/1K8+LnW3gdcBl/GQKFSTSXGjVvGBCnKpj7vIMp+0eHNYkITytFemITsXV9K9l/0L9
 pEV6lQ0UIzSKrZl/LLBuDVELbA+Z4xbDmCNzVJQXpOogzsRPnqJXdb5aULO9o8kSMKLk
 AfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202129; x=1773806929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=elIb1JyNNjCVeFtEYY42K/CrYn15CDxzMQe5v8s/VBk=;
 b=P+k+70sS+1M8mPb5IJ8fXdonEuXjxGY28vCgMQt7cWsHJrwIZ9E/Ftv6+4ZusiHlr1
 cNYviKQg/mgg4PWi0jUwg85GNj+3X8kjnbiUG7OoA/zIL6/hwCYa79PmyHXv3lWb2eAv
 sdhIjjmSRbRG5j51qP2sUkwAx1QP0aE14EU73nBEIz3N84Sy4/ZAR8teOSUFjDFjZ1P1
 gAJRSc7I2lwmN0XiVXp3C8bs/PCdOkSlTQY3f8DbOIJQn+xoGZs4a3flXkD6U7enO7OP
 d2DHZaaOGvCaZUjr6TEcHopO0bRHnCXyPXg9psD/+5zaMjY360qdUOJWOG3aYR1UnDvk
 VOHQ==
X-Gm-Message-State: AOJu0YzPTVvnBrSEzmVVvbQxyYu0zj2fhU01ylUpkEI8ykS3zQYkAL0Q
 lcTFQ/rFa/23C4NjqlSOJMUl4gupi8cEpFVua1e/c+Kr/WokA3W67RYf9NpJ0IHz46cDA4GjO7+
 DkG0U6Wl8znAGgU7C790Ns0g65C2t/J22+wlKaNT+HAqypbtNJvFHFq9w7KUfjWz8gg==
X-Gm-Gg: ATEYQzwdu7qCA8t1RIW57VooEgZ44ls9c77BRWGizFQJB4LFF1Pp1/qDDeOqhgYHtnF
 QHSZNe3hubmLprnPrGScE/IUMeceAJzuLY5nYzuETulFl6AxCZFz+gVH6RQMo5d1+Pku5uP7QQm
 jnY34kUnmNpv595jnBAizFxSSxmhF8t4eEZRDHSBxsKAeAIajsgHOeRui64GZBsChimQscwJmof
 CGZBj7pa4F97Q+teelsqX7wdBHPVeZ2lR6plL4xFt+dBy8rOQUQEpJ5mAiBcN4WEefqly+LUZQu
 3Va/RLuMqIbb2vzo5x4t591TMU660vlW/Duo2wOMTYuQMkDZnUqznTpzvbdVpxdRF6YdfFTeoVr
 6kp4rUqaP3NsItddwOm0TrlP5Ys0GIfVxb11a67pZvBEkyh6iw8Gq7YPRznZ9hvPHoKFBxQ==
X-Received: by 2002:a05:6808:1a28:b0:467:153a:2d9c with SMTP id
 5614622812f47-4671be7646fmr3486596b6e.15.1773202129516; 
 Tue, 10 Mar 2026 21:08:49 -0700 (PDT)
X-Received: by 2002:a05:6808:1a28:b0:467:153a:2d9c with SMTP id
 5614622812f47-4671be7646fmr3486569b6e.15.1773202129134; 
 Tue, 10 Mar 2026 21:08:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v3 32/32] target/hexagon: Add pcycle setting functionality
Date: Tue, 10 Mar 2026 21:07:58 -0700
Message-Id: <20260311040758.1068731-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: gxWgYW85qAfb6_LCqKtL8JFYLBs9O4Fn
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b0ead2 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=Kc8miizCJkRJjwKmxNEA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfXwVqEiVzyDySb
 TKXwXLB7rimTn4cGL6EU4pPLoGNSq8wQuWBbX/At2yJPqyOu68pi1QAqSirqN4l0FBBx8f+lCv5
 J9XSRSMUZjGodt8jwP3HhuLy0wngsOIkAw9t1MhaPnRiiRCZX42VEh9C0W1LtBVsg/9ydSeyMBf
 w785b8k84kVEQCVXdebfKlWB+/dnAZfL8dC73JKkNG2oyOMXPao61LtxE8UIK+LaO7GgXO4wILt
 548KMG/HvE4IecEZ9cXK9aUZ68KQFbm2l/rgz7oxay90wa4hKwpAstcT1cr0JPWRzpwW1nJF0OW
 T61VpP/lLGAe6Spu9ZyXKhRLIaPk/IxiRhF50ZbQEaOByr2wvSSIg0cqRYid0lR9AeWkRV4m/HE
 5yAxsVZV6o8tdwrCFm/5mj2jG4iF7vZuxCX6/kDh26hxh4D79/SbS2wfWiOWyW7PqqkEQdyqfys
 LJsG//B87V53/TIELUg==
X-Proofpoint-ORIG-GUID: gxWgYW85qAfb6_LCqKtL8JFYLBs9O4Fn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110032
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

U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpT
aWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRoYmVybkBx
dWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCA5ICsrKysrKyst
LQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVf
aGVscGVyLmMKaW5kZXggMDUyMWMwMWM4NGMuLjQzYjU1OGI2ZTY4IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5j
CkBAIC02MywxMyArNjMsMTggQEAgdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dF9sb3coQ1BVSGV4YWdvblN0YXRlICplbnYpCiB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVf
Y291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgdWludDMyX3QgY3ljbGVz
X2hpKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3QgY3VyX2N5
Y2xlcyA9IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICB1aW50NjRfdCBj
eWNsZXMgPQorICAgICAgICAoKHVpbnQ2NF90KWN5Y2xlc19oaSA8PCAzMikgfCBleHRyYWN0NjQo
Y3VyX2N5Y2xlcywgMCwgMzIpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52
LCBjeWNsZXMpOwogfQogCiB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQ
VUhleGFnb25TdGF0ZSAqZW52LAogICAgICAgICB1aW50MzJfdCBjeWNsZXNfbG8pCiB7Ci0gICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50NjRfdCBjdXJfY3ljbGVzID0gaGV4YWdv
bl9nZXRfc3lzX3BjeWNsZV9jb3VudChlbnYpOworICAgIHVpbnQ2NF90IGN5Y2xlcyA9IChleHRy
YWN0NjQoY3VyX2N5Y2xlcywgMzIsIDMyKSA8PCAzMikgfCBjeWNsZXNfbG87CisgICAgaGV4YWdv
bl9zZXRfc3lzX3BjeWNsZV9jb3VudChlbnYsIGN5Y2xlcyk7CiB9CiAKIHZvaWQgaGV4YWdvbl9z
ZXRfc3lzX3BjeWNsZV9jb3VudChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDY0X3QgY3ljbGVz
KQotLSAKMi4zNC4xCgo=

