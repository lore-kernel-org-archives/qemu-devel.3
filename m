Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F85606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oBsNMTxk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jeo9G1cm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Yc-0002sc-HV; Thu, 19 Nov 2026 15:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YR-0002om-IQ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YN-0000rA-Ub
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:23 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1F6Y3594998
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CkzLKKzs4HYMXgSYKhhd2yYEm+mi2LzoFf4VTUGF40Q=; b=oBsNMTxktF5JvzJy
 0FFoNmrhvUGPXrj8uALVv0dj0Ax4ZvHEP/TKwK4hVbIbxW2QrsF80wCFTirTTVVU
 HK7vVlr+CQnVyNIOwu0Tg4NS6nyg3awAKiwbXjSNRLyC7e99ZsE95SX6yBXp/Ugb
 pE5E8945sg9SZLyUh5CqCXAy0u5YcHthT7ARjq47yVBmCgoZs1pxMVVuH34E3D81
 GFXSLhPdZ3OEmYWT1fIGr174pBi++o51PG9T2UFIhTF04B35MlbUkt7hMtHSBZkp
 E0zH2CwfSG2ehgN48NuczY272kBPXNrEQxGHCvZ7hkpNAqk2pR9AgH19DUk9vVRO
 c1bEsQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j255wh139-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:15 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso104994eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119375; x=1795724175; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CkzLKKzs4HYMXgSYKhhd2yYEm+mi2LzoFf4VTUGF40Q=;
 b=Jeo9G1cm4C0dNo4eLIWSTP0as/e+BcNaFP5WNh6niQiFY/vhO+SNvlf9DT8LG80Ynk
 6YTFkP3M5FrhaB61LJpZRgldM2tEnSUsQXPbpy+yerF5cYERP4Op/DY68ERZclFQqcxq
 sDMkVHv5Hd0QUjAoWxksRfWHH39hxxJgyLyXVyahIw4XmfA2do8yPvukRnvxbXLrsnL6
 lLK4cuXFHQBLmOMDjAANQV7RglzhhoJL1rId2DQ80gTtstbT0d0Cs5p3evbkqRgem1o+
 Ci1jIT+8dI0nMoiRlNJvCGAhlP+un1wCfkw2Qlczx/4GfoY/sI9DEtcsGD4V9lxCRB3S
 21rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119375; x=1795724175;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CkzLKKzs4HYMXgSYKhhd2yYEm+mi2LzoFf4VTUGF40Q=;
 b=q0uUbGIsTQ5qn1Jxll9m6OQnh1REQ/FyvN1/4TjpBnDqqKTFWCzFGrwDPYdINrz6es
 9WhmFnY1SvsTcfh6v3aV3r/LzjaWP6Q6WQy5aonKmc5xlMe+V7lVUXflA0MPKuY4qsku
 qxHQh7S33q9YWA0/qABb/7kOkWzHLc5OtQgSmXr4eKnPtjfrRWSuafhClXJl2If19+A9
 4zCTjc/cGNmupgg8gKDrH68f2U060FkOMJLRY6W1rQv3VcKf9zR+CAD0q0lqPf/COQSj
 xzX3tArlUj5aUBOuBWQ3QF5QEu6xOfcvyrHO3Oc5G+9jCLprTF8O5ukDLzBsxa9ABh2w
 VkiQ==
X-Gm-Message-State: APuU4Z9r6/vC8/OLTT2WKhU4YOmkYjxps8WxNQtD3f4MfSUSGqutGZSi
 hceC+w6i6ts07ZzTW+7IqF4EnReG/3kIq7m3jhN+sJ3YUo4G5gid8+Ux8NIKl3D6HLTOF4OIe1p
 m3QQUSnc0acMy+5J+XefFo2b2w6xEDmMCvFKl0pvyWlPBq4saUekb06LabTEnZAUWoQ==
X-Gm-Gg: AZFdTZdeiCnOE+msZpNSZMfty3RNNk2f/NWvVntBmDKLussWUEskJ6L5sZkGTukHrxR
 akOMSj0cpstulExVR67E3RKU76RqjNu3UU+S9ISb7OjXEIvPeUqdZCx4wsfPHbMYRsEgTEEOIi6
 /Dc2B0ZTg74sf71VvgIsP0oRPWAEXf54PxzaB+0R69tvGNLx8bipXXr3WLdHxeIg/4CdJ8GPtJL
 WuDh2OXwDsQyJBZk6wCLHsnaqkHvvwMXGB7Zplfci7/hyr1n5CzHUVKD5Cb1uQhelJHpUfZRC4X
 kqaX8SLYwJQYtOkhPk1dfwi8URJpvCUnYN+Zaors8rDsNo3FXULDTQa2JGbNcnYkSohQhuv7Uc6
 so32KDgyf2xn+O5fQhSyqt+6tBhZ+OX/bqcOjOTwhlcgXIKtikYI8Pe0CgpvH8MWCjC4WgiJBjm
 KV+VMtCS1D60iWQStLO3Zi2g==
X-Received: by 2002:a05:693c:860a:10b0:35f:8c5d:5928 with SMTP id
 5a478bee46e88-3857073f3c4mr414679eec.30.1795119374527; 
 Thu, 19 Nov 2026 12:16:14 -0800 (PST)
X-Received: by 2002:a05:693c:860a:10b0:35f:8c5d:5928 with SMTP id
 5a478bee46e88-3857073f3c4mr414652eec.30.1795119373847; 
 Thu, 19 Nov 2026 12:16:13 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:12 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 06/14] target/hexagon: take exceptions for cache
 operations
Date: Thu, 19 Nov 2026 12:15:55 -0800
Message-Id: <20261119201603.2377989-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX3BNFtDTqVVwN
 6w0NjRO+C9yFJCqmq9e/U3AZxs7/TWd/2K4p653hOK6idPn32f/vFysBXtfrmRE3G8itzI9rqRS
 3Imr7b7QOcya/OEWIWC+c0+JblGpbjY=
X-Proofpoint-GUID: aUYXR0Qf5uh_RL_GXYyXsaAtJCUwhVkn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX2SeShfcLuP7H
 jrLihucOkMSE/GmFiIbQr/RYIYaY48wT873qBkGlb+nu7bNEbM/Y+PsZG8r18v8mr+EC/uWBIQM
 tsRaQBOF33kq+IqVhzJPJDe+2KW9PHUJhrUf8cEVH2LM+vovbIdb9EyWdfnDSqtC1mzhoHhY1BI
 7nplBkZntmJBWg6FifT09uFb/sLiA2/ZC2mVrtd0kfoWppa0sxDAJqpUllX6b9V5sMkyBe2Lp3B
 c/HeiRe3M3OuxjJxItJOvtxt2jwHBVhfbrGCFK8KuqCxwGaeGEcxsW4eMX68OrUDTPBNZbhk/4N
 QN9X44HBmHGT2RHsw7YMlrWgt9x7kM+sB2ofs6tjNI1tVSbQKouCiVVaFOr65j/A64Zztnvy1Mr
 eJYAbFpMQ3bJmZ7dv9dwo80M5+qo6WlFzk+IUHbb1RQKXz2gTv8Rv4tAnuaSufC+vdV1+WwDKN5
 b9jKFok7VwMl9GhZ9WA==
X-Authority-Analysis: v=2.4 cv=da0VTnXe c=1 sm=1 tr=0 ts=6aff590f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7Y3dZtSKsafMCO3hotIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: aUYXR0Qf5uh_RL_GXYyXsaAtJCUwhVkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190080
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

VGhlIGRjaW52YSwgZGNjbGVhbmludmEsIGRjY2xlYW5hIGFuZCBpY2ludmEgaW5zdHJ1Y3Rpb25z
IGRpZCBub3RoaW5nCmluIHN5c3RlbSBtb2RlLCBidXQgdGhlIGhhcmR3YXJlIHRyYW5zbGF0ZXMg
dGhlaXIgYWRkcmVzcy4gIEEgZGF0YSBjYWNoZQpvcGVyYXRpb24gdGFrZXMgYSBUTEIgbWlzcyBl
eGNlcHRpb24gaWYgdGhlIGFkZHJlc3MgaXMgdW5tYXBwZWQsIGFuZCBhCnByaXZpbGVnZSBleGNl
cHRpb24gaWYgdGhlIG1hcHBpbmcgY2FuIGJlIG5laXRoZXIgcmVhZCBub3Igd3JpdHRlbi4gIEFu
Cmluc3RydWN0aW9uIGNhY2hlIG9wZXJhdGlvbiBvbmx5IHRha2VzIHRoZSBUTEIgbWlzcyBleGNl
cHRpb24uCgpQcm9iZSB0aGUgYWRkcmVzcyB0aHJvdWdoIHRoZSBub3JtYWwgVExCIGZpbGwgcGF0
aCwgd2hpY2ggYWxzbyByZXBvcnRzCnRoZSBwYWNrZXQgdGhhdCBmYXVsdGVkLgoKVGhpcyBlbmFi
bGVzIHRoZSBtbXVfY2FjaGVvcHMgc3lzdGVzdC4KCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvMjAyNjExMTcxODM2MjkuMjAwMjg0MC03LW1hcmNvLmxpZWJlbEBvc3Mu
cXVhbGNvbW0uY29tLwpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5x
dWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oICAgICAgICAgICAgICAg
ICAgfCAxOCArKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCAgICAgICAgICAgICAg
ICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgICAgICAgICAgICAgICB8
IDQyICsrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVz
dF9zeXN0ZXN0cy5weSB8ICA0ICsrKwogNCBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCBi
L3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaAppbmRleCBlODJmODlhZWU0Mi4uNDBmMzVlYjgxOTkg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnLmgKQEAgLTUxMiwyMyArNTEyLDMzIEBACiAjZGVmaW5lIGZHRU5fVENHX1kyX2Rj
emVyb2EoU0hPUlRDT0RFKSBTSE9SVENPREUKICNkZWZpbmUgZkdFTl9UQ0dfWTJfZGN6ZXJvYV9u
dChTSE9SVENPREUpIFNIT1JUQ09ERQogCi0vKiBJbiBsaW51eC11c2VyIG1vZGUsIHRoZXNlIGFy
ZSBub3QgbW9kZWxsZWQsIHN1cHByZXNzIGNvbXBpbGVyIHdhcm5pbmcgKi8KKyNpZmRlZiBDT05G
SUdfVVNFUl9PTkxZCisvKiBJbiBsaW51eC11c2VyIG1vZGUsIHRoZSBkYXRhIGNhY2hlIGlzIG5v
dCBtb2RlbGxlZCAqLwogI2RlZmluZSBmR0VOX1RDR19ZMl9kY2ludmEoU0hPUlRDT0RFKSBcCiAg
ICAgZG8geyBSc1YgPSBSc1Y7IH0gd2hpbGUgKDApCiAjZGVmaW5lIGZHRU5fVENHX1kyX2RjY2xl
YW5pbnZhKFNIT1JUQ09ERSkgXAogICAgIGRvIHsgUnNWID0gUnNWOyB9IHdoaWxlICgwKQogI2Rl
ZmluZSBmR0VOX1RDR19ZMl9kY2NsZWFuYShTSE9SVENPREUpIFwKICAgICBkbyB7IFJzViA9IFJz
VjsgfSB3aGlsZSAoMCkKLQotI2lmZGVmIENPTkZJR19VU0VSX09OTFkKICNkZWZpbmUgZkdFTl9U
Q0dfWTJfaWNpbnZhKFNIT1JUQ09ERSkgXAogICAgIGdlbl9oZWxwZXJfaW5zbl9jYWNoZV9vcCh0
Y2dfZW52LCBSc1YsIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50
X3RsKGluc24tPnNsb3QpLCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25z
dGFudF90bChjdHgtPm1lbV9pZHgpLCBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRj
Z19jb25zdGFudF90bChjdHgtPnBrdC5wYykpCiAjZWxzZQorLyoKKyAqIEluIHN5c3RlbSBtb2Rl
IHRoZSBjYWNoZXMgYXJlIG5vdCBtb2RlbGxlZCBlaXRoZXIsIGJ1dCB0aGUgb3BlcmF0aW9ucwor
ICogdHJhbnNsYXRlIHRoZWlyIGFkZHJlc3Mgc28gdGhleSBjYW4gdGFrZSBUTEIgbWlzcyBhbmQg
cHJpdmlsZWdlIGV4Y2VwdGlvbnMuCisgKi8KKyNkZWZpbmUgZkdFTl9UQ0dfWTJfZGNpbnZhKFNI
T1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfZGF0YV9jYWNoZV9vcCh0Y2dfZW52LCBSc1YsIHRj
Z19jb25zdGFudF90bChjdHgtPm1lbV9pZHgpKQorI2RlZmluZSBmR0VOX1RDR19ZMl9kY2NsZWFu
aW52YShTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX2RhdGFfY2FjaGVfb3AodGNnX2Vudiwg
UnNWLCB0Y2dfY29uc3RhbnRfdGwoY3R4LT5tZW1faWR4KSkKKyNkZWZpbmUgZkdFTl9UQ0dfWTJf
ZGNjbGVhbmEoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9kYXRhX2NhY2hlX29wKHRjZ19l
bnYsIFJzViwgdGNnX2NvbnN0YW50X3RsKGN0eC0+bWVtX2lkeCkpCiAjZGVmaW5lIGZHRU5fVENH
X1kyX2ljaW52YShTSE9SVENPREUpIFwKLSAgICBkbyB7IFJzViA9IFJzVjsgfSB3aGlsZSAoMCkK
KyAgICBnZW5faGVscGVyX2luc25fY2FjaGVfb3BfY2hlY2sodGNnX2VudiwgUnNWLCBcCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF90bChjdHgtPm1lbV9p
ZHgpKQogI2VuZGlmCiAKICNkZWZpbmUgZkdFTl9UQ0dfVjJfQ0hFQ0tfQU5EX1dSSVRFX1ZTUChW
U1ApIFwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFn
b24vaGVscGVyLmgKaW5kZXggZTY1OGY4MDY4ZjQuLmU3ZTdhYjJjMDJlIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAt
MTU5LDYgKzE1OSw4IEBAIERFRl9IRUxQRVJfNShpbnNuX2NhY2hlX29wLCB2b2lkLCBlbnYsIGkz
MiwgaW50LCBpbnQsIGkzMikKIAogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCiBERUZf
SEVMUEVSXzQocmFpc2Vfc3RhY2tfb3ZlcmZsb3csIHZvaWQsIGVudiwgaTMyLCBpMzIsIGkzMikK
K0RFRl9IRUxQRVJfMyhkYXRhX2NhY2hlX29wLCB2b2lkLCBlbnYsIGkzMiwgaTMyKQorREVGX0hF
TFBFUl8zKGluc25fY2FjaGVfb3BfY2hlY2ssIHZvaWQsIGVudiwgaTMyLCBpMzIpCiBERUZfSEVM
UEVSXzIoc3dpLCB2b2lkLCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMihjc3dpLCB2b2lkLCBlbnYs
IGkzMikKIERFRl9IRUxQRVJfMihjaWFkLCB2b2lkLCBlbnYsIGkzMikKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5k
ZXggY2RiNzMxMTYwZWIuLmJkZDVkZWZjOWVjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjUsNiArMjUs
NyBAQAogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5jbHVkZSAiZXhlYy9tbWFw
LWxvY2suaCIKICNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCisjaW5jbHVkZSAiZXhlYy90
bGItZmxhZ3MuaCIKICNpbmNsdWRlICJleGVjL3RyYW5zbGF0aW9uLWJsb2NrLmgiCiAjaW5jbHVk
ZSAiZnB1L3NvZnRmbG9hdC5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgpAQCAt
MTY1OSw2ICsxNjYwLDQ3IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50MzJfdCB1aVYpCiB9CiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorLyoK
KyAqIFRoZSBkYXRhIGNhY2hlIG9wZXJhdGlvbnMgdHJhbnNsYXRlIHRoZWlyIGFkZHJlc3MuICBU
aGV5IHRha2UgYSBUTEIgbWlzcworICogZXhjZXB0aW9uIGlmIHRoZSBhZGRyZXNzIGlzIG5vdCBt
YXBwZWQsIGFuZCBhIHByaXZpbGVnZSBleGNlcHRpb24gaWYgdGhlCisgKiBtYXBwaW5nIGFsbG93
cyBuZWl0aGVyIHJlYWRzIG5vciB3cml0ZXMuCisgKi8KK3ZvaWQgSEVMUEVSKGRhdGFfY2FjaGVf
b3ApKENQVUhleGFnb25TdGF0ZSAqZW52LCB0YXJnZXRfdWxvbmcgUnNWLAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgbW11X2lkeCkKK3sKKyAgICB1aW50cHRyX3QgcmEgPSBH
RVRQQygpOworICAgIHZvaWQgKmhvc3Q7CisKKyAgICBpZiAoKHByb2JlX2FjY2Vzc19mbGFncyhl
bnYsIFJzViwgMSwgTU1VX0RBVEFfTE9BRCwgbW11X2lkeCwgdHJ1ZSwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmaG9zdCwgcmEpICYgVExCX0lOVkFMSURfTUFTSykgJiYKKyAgICAgICAg
KHByb2JlX2FjY2Vzc19mbGFncyhlbnYsIFJzViwgMSwgTU1VX0RBVEFfU1RPUkUsIG1tdV9pZHgs
IHRydWUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmhvc3QsIHJhKSAmIFRMQl9JTlZB
TElEX01BU0spKSB7CisgICAgICAgIC8qIE5vdCBhY2Nlc3NpYmxlIGF0IGFsbCwgdGFrZSB0aGUg
ZXhjZXB0aW9uIGZvciBhIHJlYWQgKi8KKyAgICAgICAgcHJvYmVfcmVhZChlbnYsIFJzViwgMSwg
bW11X2lkeCwgcmEpOworICAgIH0KK30KKworLyoKKyAqIFRoZSBpbnN0cnVjdGlvbiBjYWNoZSBv
cGVyYXRpb25zIG9ubHkgdGFrZSBhIFRMQiBtaXNzIGV4Y2VwdGlvbiwgd2hldGhlcgorICogb3Ig
bm90IHRoZSBtYXBwaW5nIGNhbiBiZSBleGVjdXRlZC4KKyAqLwordm9pZCBIRUxQRVIoaW5zbl9j
YWNoZV9vcF9jaGVjaykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBSc1YsCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBtbXVfaWR4KQoreworICAg
IGh3YWRkciBwaHlzOworICAgIGludCBwcm90OworICAgIHVpbnQ2NF90IHNpemU7CisgICAgaW50
MzJfdCBleGNwOworCisgICAgaWYgKCFoZXhhZ29uX2NwdV9tbXVfZW5hYmxlZChlbnYpKSB7Cisg
ICAgICAgIHJldHVybjsKKyAgICB9CisgICAgaWYgKCFoZXhfdGxiX2ZpbmRfbWF0Y2goZW52LCBS
c1YsIE1NVV9JTlNUX0ZFVENILCAmcGh5cywgJnByb3QsICZzaXplLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZleGNwLCBtbXVfaWR4KSkgeworICAgICAgICBwcm9iZV9hY2Nlc3MoZW52
LCBSc1YsIDEsIE1NVV9JTlNUX0ZFVENILCBtbXVfaWR4LCBHRVRQQygpKTsKKyAgICB9Cit9CisK
IHZvaWQgSEVMUEVSKHJhaXNlX3N0YWNrX292ZXJmbG93KShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3Qgc2xvdCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJf
dCBiYWR2YSwgdWludDMyX3QgcGMpCiB7CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hl
eGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5
c3Rlc3RzLnB5CmluZGV4IGY5OTc1NjNiYWNhLi41ZGMwNTI1NmFhZSAxMDA3NTUKLS0tIGEvdGVz
dHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rp
b25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTkyLDYgKzkyLDEwIEBAIGRlZiB0ZXN0
X2ZyYW1lbGltaXQoc2VsZik6CiAgICAgICAgIGV4Y2VwdGlvbiBhdCB0aGUgYWxsb2NmcmFtZSBw
YWNrZXQuIiIiCiAgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygiZnJhbWVsaW1pdCIpCiAKKyAg
ICBkZWYgdGVzdF9tbXVfY2FjaGVvcHMoc2VsZik6CisgICAgICAgICIiIkNhY2hlIG9wZXJhdGlv
bnMgcmFpc2UgVExCIG1pc3MgYW5kIHByaXZpbGVnZSBleGNlcHRpb25zLiIiIgorICAgICAgICBz
ZWxmLnJ1bl9leGl0X3plcm8oIm1tdV9jYWNoZW9wcyIpCisKICAgICBkZWYgdGVzdF9hY2Nlc3Mo
c2VsZik6CiAgICAgICAgICIiImFjY2VzcyBjaGVja3MgUl9PS3xXX09LIG9uIF90ZXN0ZmlsZV9h
Y2Nlc3MuIiIiCiAgICAgICAgIHRlc3RmaWxlID0gc2VsZi5zY3JhdGNoX2ZpbGUoIl90ZXN0Zmls
ZV9hY2Nlc3MiKQotLSAKMi4zNC4xCgo=

