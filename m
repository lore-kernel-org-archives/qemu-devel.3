Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD12CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckuO-00020g-Js; Thu, 25 Jun 2026 10:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckuM-0001sI-GH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wckuK-0000BA-7v
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:18:22 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jvpR1723469
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=; b=g7Xbf+sId0W38I4P
 bJ/1SsxHpYfmTYsK3Rvfjw1Ks0BRXm5sru2fk1Lb3g324gePaDmjB2SM5hiptTco
 jhSQ2ksYW6/JiDXu8YpJWnwKGLhFcxtQWFYx9m9UFEXOrTVeF+XCVy/bJGQ3jMc+
 otXMm4VYEFKe44bDq2Ls/SXcSE2z1aKLuKSgL/qa/TkqWKts7xJSo+b+/NvyWIW1
 rCFc5xfOlzLABXIXgm/bD0njVrR8L6uv0Z1CRasbzihbD/hiAkNKJrKEjoZDVtGO
 SAR8WAtU/GLH7txup+WMnQiMKWYmMTsd8CYjULp/Csy8222IhYONG3vea/eiPm4n
 CZEW+Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0j7dvnvx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:18:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c62861b3bso1149710eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397088; x=1783001888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=J2nEqll2ZRTBh85+MBX7OJwrJvJnN5I+uvB4RkQZKVypvtxkz7IblRDvl+mHPyGULD
 V0t5oLpf6c5dUCbT2gX4zjkhUrcIMe8/msh7/OWq8hKLoCo0iuv1z0mE/zubbBHcDX5y
 pr5hm3daQFtN7+xpTKc9c0M68oV3Mee+f9+I+sdqQu1f1/cA8xDUeh6fcc9mHFfTuE8P
 3ZqPaX6gcr7+8BmiCrdphq5b3or//+zn2fsa2A6yMbQ6Z920iapu7nBLZNGxk0o+7zBB
 N4FCBoJ7D+Qb8PTGTNDbDWJpj49ahHO5oLT0VTN+5Nsk7W1yJEdfNF1wlDFmdlyECsjH
 rRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397088; x=1783001888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=HeSxrnGq7ZRpMAIwYzbbOJ+OGXNEnniycMnskI+JE6u4f0CrpQNQKU0Qwvu2J936Ls
 hKqeVmeh95uAgXXYyLwbDXIdFOVwajV/j2/NcF+gO5nZE32QWAOVhz/PIZCS/ay1+SYC
 H6oPb0Y9S2p1gcwD3/FmWguYux48f899naAaxGuByhDsUUtkcStCLSYL+lxHmRbXekkl
 lv53DTeyCSPLrPsb3lWHFcjPDmzOl6ef673Gg3bZ11Ivs+dnX0tAr+GK4VAlUIdgF8+8
 SqmNbt6G2FqQMKENi/g0cGQBxfBU/R+shqoDaUk6ITVBKTRVZfEvjY/aA9nur8HSLRC6
 7fKg==
X-Gm-Message-State: AOJu0YxHXv1na1MxxZ/WEot9an6IYobz+lVt4w7PpiUPAuGK40CGHHc5
 t0tKgY6CEl+phcN/pjgZUcbAZiadquGDyWP6TAwqua3HBU0LIE/dAJJKFbLKiAeYnGTIQZv76a1
 7aFk42MvkQDqaKWNCK++t0G3nQHwCVAWDcayX0d59BYlD5QVlix6YoDd+PkEr33d72w==
X-Gm-Gg: AfdE7ckClH12vK2/SDDjyeSfhFdGeEj6x/aBoo5bsZD8TVTwVrmK+0JVsSze0PJ5WAN
 k86F6g4ckW4Hp0+T+nNiOEM7dMjToJRq9U9PaAS+x8G1V/C9ohKZvM+FpyUI3tie31Cr/VGZE/F
 fS8YShWanESEaLEkujbd1gyGN2I8ltWdcc+lLLhgGraWklT7+9jMWcORyeZz8oD+JzTFCVPjfTD
 XSBnXDETCpov67/jLDVpFpi5D7pEjY6ZAew6rExGm6Cst8n8KvVzuYuM2zQuciT8v6A6XkXMgX5
 j6MIPmqZqqZkhg88+n9flKBMrVpRv5f0hMgf9rERd/YlOCQv0Oq2p7lDr9VIELyRgD7bYRkr8H+
 4sGMAE9lbR3CP59qcK5LGo3IhrVHJLWr5HBZIKwaKHMDx/8ApM0GUzew1RYI=
X-Received: by 2002:a05:7301:2f8a:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-30c8489175amr3433140eec.0.1782397085660; 
 Thu, 25 Jun 2026 07:18:05 -0700 (PDT)
X-Received: by 2002:a05:7301:2f8a:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-30c8489175amr3433106eec.0.1782397085155; 
 Thu, 25 Jun 2026 07:18:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:18:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 38/76] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Thu, 25 Jun 2026 07:15:55 -0700
Message-Id: <20260625141633.449487-39-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: YpE9lzYRCLC1mU-EBj2n5Un1Bg-s-5mW
X-Authority-Analysis: v=2.4 cv=NvHhtcdJ c=1 sm=1 tr=0 ts=6a3d38a1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfX9tww/ty4RwPy
 f0eIxUo+wtVOX6A1Ed/pVmJ0G483luY139r3n5wrcCdGVZ5/qV8z+vkuYjNQrmCO3+WAQsJkezA
 bqx9GbIJCH2HtDsW157r/c6AZ6wKnNU=
X-Proofpoint-ORIG-GUID: YpE9lzYRCLC1mU-EBj2n5Un1Bg-s-5mW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXwhf+aiZ7/AGY
 30BoGSsz6JFqXueIJFaAxUjBTBQQDSFx1KYQYmd+fxXpivTqsWGzsaIConkV4FIT+seeOdxcmfB
 30VvVea5vGrksTPSMJcdj3VSHu2AYFolaobIFov8/4qXtJpQeSJ5qyDm9s+Mc+kRRCsIotXEoJu
 INdDnnJ1fY4S4Ddx01fjG9rAeDllRbM/354FtNz1uuqHiUKI7qnztLBYPf6BdVHFn/J443G/V73
 N/W57keW+P7/4M9Jg8HztGP/A0SlI5vUiyIFpdfe4OfM1aW1iBDXB0l79GrotQ59147bs9cZoK+
 C+Fr/bFEk9nRFhs9A1SF+xRTTiE6rfQYRzKwbscb5r3O7u9Aan4ksTP9B5RPH9BsbZCuS+qzbss
 4LjCaWv6puIBw4eKBnnOkmhkya6Own+qkM8YOrYWuvodayZSP5bngVfQK2gkwQ+5gwgxbUShwsW
 EGM8nUh8PFnSIHnG5/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDM4YTQzNjQ3ZGQ5Li4wNDFlNjhhMTUwZSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

