Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A790F606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GIeU2/O5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uiw5ZSCw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJf38-00010z-HR; Wed, 21 Oct 2026 18:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJf32-0000zz-D4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:44:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJf30-0002ZE-OO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:44:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKecn01502644
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=; b=GIeU2/O550MPYLAI
 yWvCqJ3VmLFdUVJldqPM4Bk/PF+HHXngggKNf+qt5jjbhl/Hum8ZzbxStoMhijH0
 NUnHWE4tF3e+4CFELreJ++BFfQWBezdUO8KW11m6sRrm7CnULp5ikNVoSl2f+6EW
 ExOlHJ5Ejm+bV3wouRc4nBkCRXnJjXWExo+RkMgxIAYOF4cjo0YNNe84qfSgJ2sR
 9Os9GK7ys7JwzusY+VgJvrhF90bVNVplQ72n/AEtdpudCHjhsS3tZtlePfjX98zK
 Io+93ZhUrTyJk8pd/uj6pmCvzSpA5hl4wEZkNH61RJy1cRHDxc7X9d9WABjVuymO
 1xVlMA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0k2hdpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 22:44:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1973772eec.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792622677; x=1793227477; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=Uiw5ZSCwfdm8NGRxkctm+9hOPMmubq7YdP0rm4wCgZhmHqyFOW1O6X8c3Ci85Qglkb
 k0ggW4gMXBEQvJho07RZ1IcHxmit9nlJ/d9UefrMWbZBAANMEnvIGGrTxt7MTp9vaKVJ
 nU7JLMaXvXi2fnJv2ZgkShcQxFGl5l4dWRRjqon8g0kdhTi/AH0grQ4rw1rTZAiuAOgE
 CdYC4CF6XNkKtG2vXDkdYpqZV7vfl3/PReEYIrNP+Ysm3KcXxj6KU/nSNQerlzgMiF6q
 SEcdDYeyjFdPvrkceEsKQAaWAvansR53wbZB5ZkLqr7lQBqkLg/IAw25MSVJ6MK3mvX7
 L41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792622677; x=1793227477;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vvu9zBmeiG5IdSolQTzttEOvEX3GYy/D7ZOye8S8kUw=;
 b=iKsdHZl/m01KYmAojXrv7G6Xilbn+pYZc1Bqz1WgnhjTW8+Xucq//yd2YDOr8r2iIP
 jAqDxfucKnHrFcQZHehCIpHLm4tuzdTFF+J+6swaAjdrueBgUojsXLzrW8IU7wH7+ujz
 KRGKZIZ4a30gh6eBXKrmg8vw2mmFwKd9MEAjnrG2rC0U56jx+DJhbrX7zmaC6OYNETPp
 6y8iL0DnkULf1icOg8hSPYOn7DYyYjLJrR+OHJ6fIHE+8W0u7rIn3EzRALXx8NerQZOY
 H2FSNeZq446LxqMi1gxlC1Vlk+yIeC4JSdE9RBF/3/wkMcUroM7dUYZUwYWLmg/AFRdV
 HHXA==
X-Gm-Message-State: AFq9FYKMFrZ3e5g0ZDPlsAWU/eUk+UJvQR2/fom39PabpAodWWJ6U/Vo
 FGTbEvmS45Dljkj4vQuI7w0rhqejoXx3HPBeme2nQLftL+282BbaYNUxNmrT2qNEnLFtpxJcc20
 V+5rEeLkY6JqC+HNlCIbXpg31vMQwfGLL2VOGdFW6lB+U1tGTcSnKLyLUbGyxOB9k2g==
X-Gm-Gg: AYBFou2FVZwYjnYp21V6L+Wzm5hUmbXuIIAfVGx85EmBAOlpf8A70eFjTa++/GQKgRL
 5mmNJsn4w93NGXDXn7UqgcsTBPzu0taBZVcGyxr9DMPT46Hk83P5uOIYAHnHuV8s+y/PhpvnWwK
 RWEaLFO12Kc8gLk/8SzZbWjD+Gaauy5fsxcRDjkARZsiqgH7ayocQ92B0QiMKoNmgTs9OmFMpoI
 r7LcA2rWsPCKbfiNAftLsPRNxOfldU2GYt5nwq30oCFyeCPuIyO/NwVl2u0SnUfFtAzabydH2Qd
 o7XkaV8G/7qj2L8oIMR+F1W2ZMFtqIU8SMjEYExtHvZENLHqz0eDhkbtfQv5srDgoOYAj8f+1Bf
 De3tQebZlm6ffY9vbRv7UekJYKNVK5uEq9JznQo6pIuwTjjX8
X-Received: by 2002:a05:7301:2514:b0:355:fdc0:a811 with SMTP id
 5a478bee46e88-3674f1150a1mr4588785eec.37.1792622676552; 
 Wed, 21 Oct 2026 15:44:36 -0700 (PDT)
X-Received: by 2002:a05:7301:2514:b0:355:fdc0:a811 with SMTP id
 5a478bee46e88-3674f1150a1mr4588757eec.37.1792622675983; 
 Wed, 21 Oct 2026 15:44:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367405ee5eesm9462858eec.8.2026.10.21.15.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 15:44:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 07/11] target/hexagon: reject reserved L4_loadw_phys
 encoding from v83
Date: Wed, 21 Oct 2026 15:44:17 -0700
Message-Id: <20261021224421.3786109-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
References: <20261021224421.3786109-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX/t/PsgbISue5
 OkF9Dwsh8z6HSyBxnrbR8eVUFcQmNcCLr3cOowzFxeNRtFjkMkCT7CTT+Pt3nWI4fc5BK2j6uT4
 tOUwQ4EmQWNjWuJhlEDOW5SSnrOS9ms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MCBTYWx0ZWRfX4zCtGDs+K+kN
 2A+BCxYaPIvwbUIGzqiwgLQTkJqgoYXmODFXOtnbSQ0eIhT1WuvUmBjxj4Ij9OjuOOrqo9JvWyT
 oi+vB1a8Mew9M61BqsjXw+SGzCTtlw/iQBXn6RjYrKHB42a/oVm4GjFdC4+J5m9USJPnpbKovDj
 95I3ewRv5kY/UKblNSo6BPXkSeEYjKBRnMGUtg02VhNHzCX3tA9sV6D2DBl0BPQAD909CxsBy93
 46n1QaXQ2aY2CKwbb9mkSvZSgSg+mlMB7iqSB8pEdz5fCYIp81T8Kndp8yL7lKJQh/6olqIHmXV
 E+udkqYCL7xk57/n9DDiIrO2ObBMuD/Fk60x2SFsBmLxPlZ6JEVLK8LEysBDlkhLxJEiprDECBF
 YQagswnT2m1RbD25R9vu427IoQSwynU4hIOLwz/aq9bLpTv68QQHm8E7i3CF9xbJeSgkgbmtcbZ
 HJUZ+ACHDRQ7R7+Fy1A==
X-Proofpoint-ORIG-GUID: rsUJSgcLx5OdbItAAHfjxuMiBtj0Kajo
X-Proofpoint-GUID: rsUJSgcLx5OdbItAAHfjxuMiBtj0Kajo
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad94055 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=EkHQ-IOB5RTo-Ixd14sA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Qml0IDcgb2YgTDRfbG9hZHdfcGh5cyBpcyB2YWxpZCB0aHJvdWdoIHY4MSBidXQgcmVzZXJ2ZWQg
c3RhcnRpbmcKd2l0aCB2ODMuIERlY29kZSBpdCBhcyBhIGxlZ2FjeSBkb24ndC1jYXJlIGJpdCwg
dGhlbiByZWplY3QgaXQgZm9yIHY4MwphbmQgbGF0ZXIuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTog
TWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL2RlY29kZS5oICAgIHwgIDIgKysKIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgIHwg
MTkgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vcHJpbnRpbnNuLmMgfCAgMyAr
Ky0KIDMgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5oIGIvdGFyZ2V0L2hleGFnb24vZGVjb2Rl
LmgKaW5kZXggZDRiMDQ5OTYxZWQuLjFlMWUzMzliMDhhIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi9kZWNvZGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuaApAQCAtMzEsNSArMzEs
NyBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCwgaW50IG1heF93b3Jkcywg
Y29uc3QgdWludDMyX3QgKndvcmRzLAogICAgICAgICAgICAgICAgICAgUGFja2V0ICpwa3QsIGJv
b2wgZGlzYXNfb25seSk7CiAKIGJvb2wgb3Bjb2RlX3N1cHBvcnRlZCh1aW50MTZfdCBvcGNvZGUs
IGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpOworYm9vbCBlbmNvZGluZ19zdXBwb3J0ZWQo
dWludDE2X3Qgb3Bjb2RlLCB1aW50MzJfdCBlbmNvZGluZywKKyAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpOwogCiAjZW5kaWYKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKaW5kZXgg
YTI4YmY5Y2U5ZmUuLjM1ZDc0MWNlODY0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9kZWNv
ZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpAQCAtNjkyLDYgKzY5MiwyMiBAQCBi
b29sIG9wY29kZV9zdXBwb3J0ZWQodWludDE2X3Qgb3Bjb2RlLCBjb25zdCBIZXhhZ29uQ1BVRGVm
ICpoZXhfZGVmKQogICAgIHJldHVybiB0cnVlOwogfQogCisvKgorICogU29tZSBlbmNvZGluZ3Mg
b2YgYW4gb3RoZXJ3aXNlIHN1cHBvcnRlZCBvcGNvZGUgYXJlIHJlc2VydmVkIG9uIG5ld2VyCisg
KiB2ZXJzaW9ucy4gIEhFWF9WRVJfQU5ZICh1c2VkIHdoZW4gb25seSBkaXNhc3NlbWJsaW5nKSBh
Y2NlcHRzIGV2ZXJ5dGhpbmcuCisgKi8KK2Jvb2wgZW5jb2Rpbmdfc3VwcG9ydGVkKHVpbnQxNl90
IG9wY29kZSwgdWludDMyX3QgZW5jb2RpbmcsCisgICAgICAgICAgICAgICAgICAgICAgICBjb25z
dCBIZXhhZ29uQ1BVRGVmICpoZXhfZGVmKQoreworICAgIC8qIEJpdCA3IG9mIEw0X2xvYWR3X3Bo
eXMgYmVjYW1lIHJlc2VydmVkIGluIHY4My4gKi8KKyAgICBpZiAoaGV4X2RlZi0+aGV4X3ZlcnNp
b24gIT0gSEVYX1ZFUl9BTlkgJiYKKyAgICAgICAgaGV4X2RlZi0+aGV4X3ZlcnNpb24gPj0gSEVY
X1ZFUl9WODMgJiYKKyAgICAgICAgb3Bjb2RlID09IEw0X2xvYWR3X3BoeXMgJiYgKGVuY29kaW5n
ICYgMHg4MCkpIHsKKyAgICAgICAgcmV0dXJuIGZhbHNlOworICAgIH0KKyAgICByZXR1cm4gdHJ1
ZTsKK30KKwogLyoKICAqIGRlY29kZV9wYWNrZXQKICAqIERlY29kZXMgcGFja2V0IHdpdGggZ2l2
ZW4gd29yZHMKQEAgLTcyMiw2ICs3MzgsOSBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IG1heF93b3JkcywgY29uc3QgdWludDMyX3QgKndvcmRzLAogICAgICAgICAg
ICAgLyogSW52YWxpZCBpbnN0cnVjdGlvbiBlbmNvZGluZyAqLwogICAgICAgICAgICAgcmV0dXJu
IDA7CiAgICAgICAgIH0KKyAgICAgICAgaWYgKCFlbmNvZGluZ19zdXBwb3J0ZWQoaW5zbi0+b3Bj
b2RlLCBlbmNvZGluZzMyLCBjdHgtPmhleF9kZWYpKSB7CisgICAgICAgICAgICByZXR1cm4gMDsK
KyAgICAgICAgfQogICAgICAgICAvKgogICAgICAgICAgKiBJZiB3ZSBzYXcgYW4gZXh0ZW5kZXIs
IG1hcmsgbmV4dCB3b3JkIGV4dGVuZGVkIHNvIGltbWVkaWF0ZQogICAgICAgICAgKiBkZWNvZGUg
d29ya3MKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3ByaW50aW5zbi5jIGIvdGFyZ2V0L2hl
eGFnb24vcHJpbnRpbnNuLmMKaW5kZXggMDIzZWExMmRiYTUuLmNkYjlkY2Q3ZGU5IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9wcmludGluc24uYworKysgYi90YXJnZXQvaGV4YWdvbi9wcmlu
dGluc24uYwpAQCAtMTcxLDcgKzE3MSw4IEBAIHZvaWQgc25wcmludF9hX3BrdF9kaXNhcyhHU3Ry
aW5nICpidWYsIFBhY2tldCAqcGt0LCB1aW50MzJfdCAqd29yZHMsCiAgICAgICAgIH0KIAogICAg
ICAgICBnX3N0cmluZ19hcHBlbmQoYnVmLCAiXHQiKTsKLSAgICAgICAgaWYgKG9wY29kZV9zdXBw
b3J0ZWQocGt0LT5pbnNuW2ldLm9wY29kZSwgY2ZnLT5oZXhfZGVmKSkgeworICAgICAgICBpZiAo
b3Bjb2RlX3N1cHBvcnRlZChwa3QtPmluc25baV0ub3Bjb2RlLCBjZmctPmhleF9kZWYpICYmCisg
ICAgICAgICAgICBlbmNvZGluZ19zdXBwb3J0ZWQocGt0LT5pbnNuW2ldLm9wY29kZSwgd29yZHNb
aV0sIGNmZy0+aGV4X2RlZikpIHsKICAgICAgICAgICAgIHNucHJpbnRpbnNuKGJ1ZiwgJihwa3Qt
Pmluc25baV0pKTsKICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgIGdfc3RyaW5nX2FwcGVu
ZChidWYsICI8aW52YWxpZD4iKTsKLS0gCjIuMzQuMQoK

