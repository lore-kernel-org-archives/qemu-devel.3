Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC922C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we398-0001Xf-A5; Sun, 28 Jun 2026 23:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we392-0001Vg-W6
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we38z-0006BE-2v
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:51 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cvqF1549945
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=; b=aA
 CSVTnI3LO3xdaAweRWZpSl7kV9+ZA8kq9RvKgKNA0ks8OoR/KXYLKn0D8gL6bxz0
 MrrR8FxB+1fNqqORF/1KzKKQPoQRhmWswr9HXwuUTvqSQ7wAD9HdiWWCNkRakCAX
 8cSEPocLTFSqcGnUiO9+3ImdfBckvBYNnEZ6TvrN20/0Jsx7ODuChENEELaad5Cp
 l8ak+K1UB5fCeV4ZwvZv6WBHd0lpsKEw2qAsKPOjO4zI4voSBvb/OhhO4wnD2Hpd
 YzEfT9tawfE69AxvDai/RfS+pxNkiWVpPPRhv1JhByJatPlp6HZ6+nlck9N3aQdi
 liwYzxO7HGh2nycEIxrw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mdqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:47 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b70ca7e5so5902853c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705526; x=1783310326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=;
 b=GbsJeBNSd58YUua9RIscJNyMDplhFKqySMsHLq1sQ1R3e1CXebjgVYONIrdcx8+96l
 ODGk3jN0GPQNX8/2c+5GqvgyOyC7E7mzQKoZwFbfUZNmLwcnkNILB6OfuWtVmviB4U6Z
 5Lj8R4OD3YuoxqoV8AA36Agkc5kKjVfTWyVJ1wtGSJlvTJsoF57aOrA0s6+6vvRvpX9f
 rAMqLMdzSeSW/SPp7jstX7CY5i+QkwJPXfgF1X+R1sw04E3jrNIRzJWbWcI+x2bOiTUO
 v3Z+8iR2CnCGS81WawM2lU02Lgy8zShySrhRkfYztqTJIs+UlOQ+egCBys/INFRHowNh
 8VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705526; x=1783310326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GLP31WMp9ya2aQSzhpJX7UU63XGBhoUjedxw7x1beJQ=;
 b=GxXLPyX7HsYuJvXfB5KwkfYrZHVFLnwpNiE8EYMNX57xNKlRDt70pE3HvfFlhi+Xfj
 KYE800M+kDeQJEduaw2Yi8Nu0KYVUfJkRKY+TAS8sVcSRpAZssvCpH1NiHwcN60WQ++W
 rS582lj86hwEVmAusUE8eQKh3DKDKhvFj7pMU/einTKzhAIWqGHk9oPy/mf9zkVeRR5d
 HeXK00Jv9m6eWUcmNmgkVWWkUAsgb21fbiBqeSfHFwPSk3tDfOvA5jDFufjNEhquRR3/
 VMsQWIjH0zAn+FvMvyZkfj2xbWKKdI0loh9/cvfYBI5hT4dUzhbATxbgqz6Fz2EdUhbr
 9s+A==
X-Gm-Message-State: AOJu0YxQHBksxzo3uCFlwT1UsI8uK9TBX48ndbyFFro3nELJCjdJTpc1
 3mbphCIVEXjNYyunXwx83owXuux0bZ/WZqGu9kCQwmORQbMORx9EIeEts8gfduLtcYPXWlwB3Kx
 rJryozlyr8QdkP/zIqtRrqkUKP5FvF3C2WydAPG8CoVQnc7QVgaRWxZVBkLiORQghsg==
X-Gm-Gg: AfdE7clGHEsXkbpt1WL8XoxdohyXFf4q+4JUXs7+lDK45XvN/fgjQ52cxAW+9fGCT6E
 f0m6n6VAw6zOdBSmDQUodyj+NWZwRZtzFBAwa+evItnAhHMRnHSUR+E3iGNMmFQbrzjPRfv4W4w
 5L5UVKlSk2+mpTp9yYvDYrOO6bzIYWrzkWtSupVe/aJq+0jefVFZ+MZU2Evb38bHgipN1neMbGc
 I0FNfbibsUDIOvOByyNjeZ3rE6ig6TurGHaz4knwxLNvk2GdNtb1HYTf1E/nc0N3CIltjdIfH8+
 djbOhO6x+NvLMRs6WARhQNhk4lZnBzdMRc5Gi8+A2SuqRdU8cziks+FiBTgVTAFXwCeBEuaNFgF
 bfDyGU8P5IIsrvH4EYTrMW6TyUx7riXdunqnndA4+s/1h1XzbgC7WIphJNIE=
X-Received: by 2002:a05:7022:23a0:b0:136:d237:b42f with SMTP id
 a92af1059eb24-139dbaba184mr13286122c88.32.1782705526092; 
 Sun, 28 Jun 2026 20:58:46 -0700 (PDT)
X-Received: by 2002:a05:7022:23a0:b0:136:d237:b42f with SMTP id
 a92af1059eb24-139dbaba184mr13286108c88.32.1782705525639; 
 Sun, 28 Jun 2026 20:58:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 03/77] target/hexagon: use cmd_array() instead of get_id()
Date: Sun, 28 Jun 2026 20:57:16 -0700
Message-Id: <20260629035830.1520296-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX8Sx5aafhfdM1
 AAxWz7GXAUbZml6SwtTymWB/KL213Zwp5XtzbOScfNUxkKwjqfJUqEFdGgJUUFLzVcJJL4lZNT0
 JJtGDO1s8cfdn2Wvb9MKbFFNYM03di0=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41ed77 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=SrZkeIdwbWuKvdoqoQQA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: wxw-wkM67ekyBv0AOAuqj3CfzoKKejFT
X-Proofpoint-ORIG-GUID: wxw-wkM67ekyBv0AOAuqj3CfzoKKejFT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX5jVGDg6H0pYH
 8oV4yQ6qwyJq12CZcWZ6yDZWDBd8n5LWv6iobwzovuhEaR+/pAwerGxnutNpnXOq4hF9F7fRDC8
 Hz+F2bqw2NWQ2DJaOMEutNDHmA8hh6lB5z6zXvKviDX52JnPIFSBtLjmkPESJf3sH2y0BAyRDL7
 w6TtBtRBQheB0lNbxlDrjEYstp1HGoaZfIpjzMqi8GM+k1bh6ixvnrWzqpjKGzet61m8J/a0Kqi
 Ya5qGS6fwyLW9j5EGfYdswHp9+n8F8L/rL5zyZbtgjq9Y7IhVIJCqyM/RA6YIA1TgeMmQILANBU
 fJ+JD+rMzIm+LqgUfskUSrl2a5XgMS01jhlzZ68++Tj9+05NSB/oE1DCIMSU2cfY1ZveJ35qz+h
 2aLubZCqLNWwZpWT52xfI4HR4B43xtE7HB9hzE1suowWfGUowmEUxM4yoc5RLgjHsfSWeYNJUOz
 /jIGN9FATQIeUVpW3kA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

Z2V0X2lkKCkgcmV0dXJucyB0aGUgY29tcGlsZXIncyBzaG9ydCBuYW1lIG5vdCBhIHByb2dyYW0u
ClBhc3NpbmcgaXQgZGlyZWN0bHkgYXMgdGhlIGNvbW1hbmQgZm9yIHRoZSBpZGVmLXBhcnNlciBw
cmVwcm9jZXNzaW5nCmN1c3RvbV90YXJnZXQgaGFwcGVuZWQgdG8gd29yayBmb3IgbmF0aXZlIGdj
Yy9jbGFuZyBidWlsZHMgYnV0CmJyZWFrcyB1bmRlciBjcm9zcyBjb21waWxlcnMgc3VjaCBhcyBl
bWNjIG9yIGFueSBjY2FjaGUtd3JhcHBlZCBjb21waWxlci4KCkxpbms6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FKU1AwUVd6UUVnb1lNQ2daWCs5akN2clY2TzNScW5BK2Rm
MURwVDJSNk1adlZYaU5nQG1haWwuZ21haWwuY29tLwpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5v
Y3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vbWVzb24uYnVpbGQgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQg
Yi90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBkMTY5Y2Y3MWIyZi4uZmYyMmI0ZTQ3
MDYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCisrKyBiL3RhcmdldC9o
ZXhhZ29uL21lc29uLmJ1aWxkCkBAIC0yNzAsMTMgKzI3MCwxMyBAQCBpZiBpZGVmX3BhcnNlcl9l
bmFibGVkIGFuZCAnaGV4YWdvbi1saW51eC11c2VyJyBpbiB0YXJnZXRfZGlycwogICAgICAgICBj
b21tYW5kOiBbcHl0aG9uLCBmaWxlcygnZ2VuX2lkZWZfcGFyc2VyX2Z1bmNzLnB5JyksIHNlbWFu
dGljc19nZW5lcmF0ZWQsICdAT1VUUFVUQCddLAogICAgICkKIAotICAgIGNvbXBpbGVyID0gbWVz
b24uZ2V0X2NvbXBpbGVyKCdjJykuZ2V0X2lkKCkKKyAgICBjb21waWxlciA9IG1lc29uLmdldF9j
b21waWxlcignYycpLmNtZF9hcnJheSgpCiAgICAgcHJlcHJvY2Vzc2VkX2lkZWZfcGFyc2VyX2lu
cHV0X2dlbmVyYXRlZCA9IGN1c3RvbV90YXJnZXQoCiAgICAgICAgICdpZGVmX3BhcnNlcl9pbnB1
dC5wcmVwcm9jZXNzZWQuaC5pbmMnLAogICAgICAgICBvdXRwdXQ6ICdpZGVmX3BhcnNlcl9pbnB1
dC5wcmVwcm9jZXNzZWQuaC5pbmMnLAogICAgICAgICBpbnB1dDogaWRlZl9wYXJzZXJfaW5wdXRf
Z2VuZXJhdGVkLAogICAgICAgICBkZXBlbmRfZmlsZXM6IFtpZGVmX3BhcnNlcl9kaXIgLyAnbWFj
cm9zLmguaW5jJ10sCi0gICAgICAgIGNvbW1hbmQ6IFtjb21waWxlciwgJy14JywgJ2MnLCAnLUUn
LCAnLUknLCBpZGVmX3BhcnNlcl9kaXIsICctbycsICdAT1VUUFVUQCcsICdASU5QVVRAJ10sCisg
ICAgICAgIGNvbW1hbmQ6IGNvbXBpbGVyICsgWycteCcsICdjJywgJy1FJywgJy1JJywgaWRlZl9w
YXJzZXJfZGlyLCAnLW8nLCAnQE9VVFBVVEAnLCAnQElOUFVUQCddLAogICAgICkKIAogICAgIGZs
ZXggPSBnZW5lcmF0b3IoCi0tIAoyLjM0LjEKCg==

