Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F9B10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqL-0003Eq-Fl; Wed, 08 Apr 2026 14:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAXqH-0002nR-MX
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKP4-0005br-Dq
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637J6brG071736
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +DBy8cpz3t6fbfMdXgVv+lAhN/yuUk5Xigz3myWM3io=; b=Z3vkoSvBlVJ9rhI8
 yRu9UaGgDRubp+5xkCKX3xDiWvZJ6oqepVZOvr6vySDObwgMF+GEyyEtdMzQnY5c
 o6GGqRYxThNPC5iqgkwN4hr+KjPJhsiGIWOsS+3hS3VglMTh8Jw8X3N1olwVzozl
 /fQkC2IaWAn6scwb82zf5zkM+j+ynudtEtA11fPMPpfgsjI2pdAJzf4MAXfTOLgb
 cxUvZ6aAcs0gqE/OfwoQkst4RwsGdq37S6cb4/kTWvcW8s8RD9lS5WXVV+xsAhkH
 vXjQ1yhrXRpY8foUgTN/DW4uSVg99FU01DVNCFx9nKg+ukpHwu6MkGPfzPtVB/cJ
 ngSaXw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd7sx9dr0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so7962885eec.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622029; x=1776226829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+DBy8cpz3t6fbfMdXgVv+lAhN/yuUk5Xigz3myWM3io=;
 b=E+JYgrsilYm8jZHBbHFzXxILWt20wP6ygJ9SK7GjHfoL8xvsJnPjbKyA+E0oR7JmTh
 vafIAjGsXFSDm2dCfGGyu0WBbM2BeIK0VqrEE0Sx9MzidC9XkaCLTD21k6K3d93dT4wz
 1oqXazKmOmQNMfeiSYT73KoGdZnh67hrH7l49eAU7IsFH5a1VPz97CqfwhGhY+Iv+DRo
 qgiZsfSwoTFFr71lLGiI5LbrfTVi/vHr/tVaHJxemEbCM+K932CnRoudF4Vkw07DLyg0
 J0zQ8Bb5D1+dXwndliJzY5D7qKq7yWfD6PE92xbY0ciNUnzsaP68/iM2UPWsXeq8oMBs
 i8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622029; x=1776226829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+DBy8cpz3t6fbfMdXgVv+lAhN/yuUk5Xigz3myWM3io=;
 b=KDbDfncoBeYEZbcmtMLLIJCqSmnNU7HafTxfdwN+/04iLySnAWvSqvrkaocAqdYRkQ
 f3DIz6Q2oAQSlCA4xC6KOO4U0OaTY/2+AVkkZ7ezb/tcN7SrvomA95MwcYos1esGjb9u
 kxIglGamEAn50vS+3jnAMrh1CiSdw2H/GYzQyOtWHrC89telWvjgkV0+Zdx10RPXSdnw
 t5hEo1ykB6gGeccdQq3GwJ0Fs9DGpy+2n4ZZGRlSG8yx4vAR6tr9hUvJlb9Lx7d5sqhk
 pOmAxHUKoaAtAv/WK+c4zMMGjPzjnU+DuhE1/Jd8NsL+fvPTwQ0DQ1mlTOHhawOhyBSz
 qtPA==
X-Gm-Message-State: AOJu0Yx9A4xGAmPfQ+ZqAU+PRKD/8rHJqEScX2WTlkvakobmXwfOw2ub
 OW50AQeAZTj+cHuyW7ljOdlhwOmvIefQijFjkqtiO77tzvD/SBHnAtVPWIM43cIKHRCceMD7/YJ
 NhMK7HYvvif7JfQo9mjRPGiqz5QgwmYYmZPOSQuB8+b9sJsEX4E0x+3W6VmKhGRNb+g==
X-Gm-Gg: AeBDievWJgGYbUNISdnfRolM9CVkzYQn7QeXL0Y2ko3j8kacgErkrHmG7Nt7bD5RhWM
 JDrI4tP22RvAynzgJCoKAiwE5hsCWVSh/pRiig/N+q2W0548BV/qGxOOveBDEwHqpREKcB6LeLI
 mBz+k5yaQakTU4xBVD10Y5/RoChFaAX84JjHJ0YdeEsQDeclGrZSc+ek4bEepTNnUTHbqRWOFrN
 E7bsbOn28mUXk7bjBaeqqO+JqI80/CElQx9835sk0oGVBQ2RViUd6cmEwO0SryLaqtJ6lBHk/60
 2b0LtYOEJk4GG9TiFu8u8IwfxYIJ6KaWE4wBmHUsakGcs0C/pO8hXiCVcG6Rm7wKKy/hzx6TFgI
 2vXuLzmC+eQDkcJj1P0RXuT/rNEbxUnLtdzAG3wfkG0DUzeai/I2W/oldcBSo+ZtVGuDZLQ==
X-Received: by 2002:a05:7022:10d:b0:128:d967:4678 with SMTP id
 a92af1059eb24-12bfb74427cmr8926982c88.23.1775622028557; 
 Tue, 07 Apr 2026 21:20:28 -0700 (PDT)
X-Received: by 2002:a05:7022:10d:b0:128:d967:4678 with SMTP id
 a92af1059eb24-12bfb74427cmr8926971c88.23.1775622027951; 
 Tue, 07 Apr 2026 21:20:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 20/28] target/hexagon: Add pkt_ends_tb to translation
Date: Tue,  7 Apr 2026 21:19:45 -0700
Message-Id: <20260408041953.1899532-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=etfvCIpX c=1 sm=1 tr=0 ts=69d5d78e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=PUAfe4L2FItr89aHCx8A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9CnVWTjHxX9pc4q4UV-kux8U2TPAn3dy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNSBTYWx0ZWRfXzVtnMOBPkQ73
 MCMdLnlqYcOBKJj75WzE0dp3UUbqkehX6pZTqvpQ2C4g4B/M1LZgMZUysSlPdP/Pd83LfuFMhQ6
 H1r6rLin1eiUiaGQV5xjPzLhYGg7ae6CyVMGwEfgnBOXabV510XGhojBUgZ3Otyy8WmcNKOjtIZ
 2XU+xiCsDohb+D+hmsV4M9dWat6O/dJtJwqnhm7rkuHoscW72in6V2DSiWaZX8DNhNiEzhNgMjQ
 rfTn1yG7W1a4Ca1fhTQw+cFEcAoxkeq4S17XplSfAikIrgwb3MKZdpxkh8CGDmIqe4drxaIzeUM
 AQFUmYY+IL3DhzuKMyytRXC/H890XkcVt9XtslivH0YK92n1/RXM3pPrWlqusNF3q4tKXUZj3VB
 vgqqFFBlvu/ZHrE6XqxV1TMj/IAtoFYD4cm2xICR3ZAzS+uLPZc+B2RC932qQnnsWSEyz22aNVW
 4GP9MDnzUfzPbGO8nfQ==
X-Proofpoint-GUID: 9CnVWTjHxX9pc4q4UV-kux8U2TPAn3dy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080035
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgICAxIC0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIHwgMTAxICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KIDIgZmlsZXMgY2hhbmdlZCwgOTkgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuaCBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IDRlMDkwNTY1YWFj
Li44MmIzMjczMTJlYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKKysr
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKQEAgLTg1LDcgKzg1LDYgQEAgdHlwZWRlZiBz
dHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBUQ0d2IGJyYW5jaF90YWtlbjsKICAgICBUQ0d2IGRj
emVyb19hZGRyOwogICAgIGJvb2wgcGN5Y2xlX2VuYWJsZWQ7Ci0gICAgYm9vbCBwa3RfZW5kc190
YjsKICAgICB1aW50MzJfdCBudW1fY3ljbGVzOwogfSBEaXNhc0NvbnRleHQ7CiAKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRl
LmMKaW5kZXggMDc4MjkwNjM4NjguLjZiYmExMzVmNjkyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMjcy
LDYgKzI3MiwxNiBAQCBzdGF0aWMgYm9vbCBjaGVja19mb3JfYXR0cmliKFBhY2tldCAqcGt0LCBp
bnQgYXR0cmliKQogICAgIHJldHVybiBmYWxzZTsKIH0KIAorc3RhdGljIGJvb2wgY2hlY2tfZm9y
X29wY29kZShQYWNrZXQgKnBrdCwgdWludDE2X3Qgb3Bjb2RlKQoreworICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgcGt0LT5udW1faW5zbnM7IGkrKykgeworICAgICAgICBpZiAocGt0LT5pbnNuW2ld
Lm9wY29kZSA9PSBvcGNvZGUpIHsKKyAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICB9
CisgICAgfQorICAgIHJldHVybiBmYWxzZTsKK30KKwogc3RhdGljIGJvb2wgbmVlZF9zbG90X2Nh
bmNlbGxlZChQYWNrZXQgKnBrdCkKIHsKICAgICAvKiBXZSBvbmx5IG5lZWQgc2xvdF9jYW5jZWxs
ZWQgZm9yIGNvbmRpdGlvbmFsIHN0b3JlIGluc3RydWN0aW9ucyAqLwpAQCAtMjg1LDYgKzI5NSw5
MCBAQCBzdGF0aWMgYm9vbCBuZWVkX3Nsb3RfY2FuY2VsbGVkKFBhY2tldCAqcGt0KQogICAgIHJl
dHVybiBmYWxzZTsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMgYm9vbCBz
cmVnX3dyaXRlX2VuZHNfdGIoaW50IHJlZ19udW0pCit7CisgICAgcmV0dXJuIHJlZ19udW0gPT0g
SEVYX1NSRUdfU1NSIHx8CisgICAgICAgICAgIHJlZ19udW0gPT0gSEVYX1NSRUdfU1RJRCB8fAor
ICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVHX0lNQVNLIHx8CisgICAgICAgICAgIHJlZ19u
dW0gPT0gSEVYX1NSRUdfSVBFTkRBRCB8fAorICAgICAgICAgICByZWdfbnVtID09IEhFWF9TUkVH
X0JFU1RXQUlUIHx8CisgICAgICAgICAgIHJlZ19udW0gPT0gSEVYX1NSRUdfU0NIRURDRkc7Cit9
CisKK3N0YXRpYyBib29sIGhhc19zcmVnX3dyaXRlX2VuZHNfdGIoUGFja2V0IGNvbnN0ICpwa3Qp
Cit7CisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBwa3QtPm51bV9pbnNuczsgaSsrKSB7CisgICAg
ICAgIEluc24gY29uc3QgKmluc24gPSAmcGt0LT5pbnNuW2ldOworICAgICAgICB1aW50MTZfdCBv
cGNvZGUgPSBpbnNuLT5vcGNvZGU7CisgICAgICAgIGlmIChvcGNvZGUgPT0gWTJfdGZyc3Jjcikg
eworICAgICAgICAgICAgLyogV3JpdGUgdG8gYSBzaW5nbGUgc3JlZyAqLworICAgICAgICAgICAg
aW50IHJlZ19udW0gPSBpbnNuLT5yZWdub1swXTsKKyAgICAgICAgICAgIGlmIChzcmVnX3dyaXRl
X2VuZHNfdGIocmVnX251bSkpIHsKKyAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICAg
ICAgICAgIH0KKyAgICAgICAgfSBlbHNlIGlmIChvcGNvZGUgPT0gWTRfdGZyc3BjcCkgeworICAg
ICAgICAgICAgLyogV3JpdGUgdG8gYSBzcmVnIHBhaXIgKi8KKyAgICAgICAgICAgIGludCByZWdf
bnVtID0gaW5zbi0+cmVnbm9bMF07CisgICAgICAgICAgICBpZiAoc3JlZ193cml0ZV9lbmRzX3Ri
KHJlZ19udW0pKSB7CisgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CisgICAgICAgICAgICB9
CisgICAgICAgICAgICBpZiAoc3JlZ193cml0ZV9lbmRzX3RiKHJlZ19udW0gKyAxKSkgeworICAg
ICAgICAgICAgICAgIHJldHVybiB0cnVlOworICAgICAgICAgICAgfQorICAgICAgICB9CisgICAg
fQorICAgIHJldHVybiBmYWxzZTsKK30KKyNlbmRpZgorCitzdGF0aWMgYm9vbCBwa3RfZW5kc190
YihQYWNrZXQgKnBrdCkKK3sKKyAgICBpZiAocGt0LT5wa3RfaGFzX2NvZikgeworICAgICAgICBy
ZXR1cm4gdHJ1ZTsKKyAgICB9CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICAvKiBTeXN0
ZW0gbW9kZSBpbnN0cnVjdGlvbnMgdGhhdCBlbmQgVExCICovCisgICAgaWYgKGNoZWNrX2Zvcl9v
cGNvZGUocGt0LCBZMl9zd2kpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9j
c3dpKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfY2lhZCkgfHwKKyAgICAg
ICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFk0X3NpYWQpIHx8CisgICAgICAgIGNoZWNrX2Zvcl9v
cGNvZGUocGt0LCBZMl93YWl0KSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJf
cmVzdW1lKSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfaWFzc2lnbncpIHx8
CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9zZXRpbWFzaykgfHwKKyAgICAgICAg
Y2hlY2tfZm9yX29wY29kZShwa3QsIFk0X25taSkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29k
ZShwa3QsIFkyX3NldHByaW8pIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9z
dGFydCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX3N0b3ApIHx8CisgICAg
ICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9rMGxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zv
cl9vcGNvZGUocGt0LCBZMl9rMHVubG9jaykgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShw
a3QsIFkyX3RsYmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl90bGJ1
bmxvY2spIHx8CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9icmVhaykgfHwKKyAg
ICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX2lzeW5jKSB8fAorICAgICAgICBjaGVja19m
b3Jfb3Bjb2RlKHBrdCwgWTJfc3luY2h0KSB8fAorICAgICAgICBjaGVja19mb3Jfb3Bjb2RlKHBr
dCwgWTJfdGxicCkgfHwKKyAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFkyX3RsYncpIHx8
CisgICAgICAgIGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZNV9jdGxidykgfHwKKyAgICAgICAgY2hl
Y2tfZm9yX29wY29kZShwa3QsIFk1X3RsYmFzaWRpKSkgeworICAgICAgICByZXR1cm4gdHJ1ZTsK
KyAgICB9CisKKyAgICAvKgorICAgICAqIENoZWNrIGZvciBzcmVnIHdyaXRlcyB0aGF0IHdvdWxk
IGVuZCB0aGUgVEIKKyAgICAgKi8KKyAgICBpZiAoY2hlY2tfZm9yX2F0dHJpYihwa3QsIEFfSU1Q
TElDSVRfV1JJVEVTX1NTUikpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAgIGlm
IChoYXNfc3JlZ193cml0ZV9lbmRzX3RiKHBrdCkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7Cisg
ICAgfQorI2VuZGlmCisgICAgcmV0dXJuIGZhbHNlOworfQorCisKIHN0YXRpYyBib29sIG5lZWRf
bmV4dF9QQyhEaXNhc0NvbnRleHQgKmN0eCkKIHsKICAgICBQYWNrZXQgKnBrdCA9IGN0eC0+cGt0
OwpAQCAtNDQ3LDcgKzU0MSwxMCBAQCBzdGF0aWMgdm9pZCBhbmFseXplX3BhY2tldChEaXNhc0Nv
bnRleHQgKmN0eCkKIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQoRGlzYXNDb250ZXh0ICpj
dHgpCiB7CiAgICAgUGFja2V0ICpwa3QgPSBjdHgtPnBrdDsKLSAgICB0YXJnZXRfdWxvbmcgbmV4
dF9QQyA9IGN0eC0+YmFzZS5wY19uZXh0ICsgcGt0LT5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsK
KyAgICB1aW50MzJfdCBuZXh0X1BDID0gKGNoZWNrX2Zvcl9vcGNvZGUocGt0LCBZMl9rMGxvY2sp
IHx8CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hlY2tfZm9yX29wY29kZShwa3QsIFky
X3RsYmxvY2spKSA/CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3R4LT5iYXNlLnBj
X25leHQgOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGN0eC0+YmFzZS5wY19uZXh0
ICsgcGt0LT5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKICAgICBpbnQgaTsKIAogICAgIC8qIENs
ZWFyIG91dCB0aGUgZGlzYXNzZW1ibHkgY29udGV4dCAqLwpAQCAtOTU5LDcgKzEwNTYsNyBAQCBz
dGF0aWMgdm9pZCBnZW5fY29tbWl0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAg
cGt0LT52aGlzdF9pbnNuLT5nZW5lcmF0ZShjdHgpOwogICAgIH0KIAotICAgIGlmIChwa3QtPnBr
dF9oYXNfY29mKSB7CisgICAgaWYgKHBrdF9lbmRzX3RiKGN0eC0+cGt0KSB8fCBjdHgtPmJhc2Uu
aXNfam1wID09IERJU0FTX05PUkVUVVJOKSB7CiAgICAgICAgIGdlbl9lbmRfdGIoY3R4KTsKICAg
ICB9CiB9Ci0tIAoyLjM0LjEKCg==

