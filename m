Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7979ECA5FA0
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 02:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAeru-00052a-Cm; Sat, 26 Sep 2026 22:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAers-00051u-EY
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerq-0007Uf-4w
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:43:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNHIle1478410
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hajtpxF2Cztk5kuYRbyQnh/pr7a1DMFLfRCtDXBoNmY=; b=XRRBi1VO/3+O68gC
 8EjHzW6Q0eLFlmSRyNZfyZy9kStzBRdgWjBkNV5Y943aXs7AUZUfg1/hl+/jkmUW
 wEGCDxuOYY585m1BCelUv6QuMmKRczDj4heDRdEqc7DrT4fOB7N2wOHemwrymAmU
 4dFkhUeDeFFzgT4Bzd5IaTaFgpIaSkFbAQQON9n5lbk3iZX9+E+GOXpmL0IvFSxE
 lghSUT8Vls/3zRtlGiw7+/Fc4eaZB9SCT0SJmbr76PzrJXGMtgtOhMTBkmwxFQwS
 0Qmr9orxhs2ZU8G5TxV/mS05kOmg4UZgmfykQeLwfFqx8qUHwb0+qameSMuShGqd
 nN6zng==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526j89d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-342b66c0b06so1404985eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790477031; x=1791081831; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hajtpxF2Cztk5kuYRbyQnh/pr7a1DMFLfRCtDXBoNmY=;
 b=iPpVkay7E7tJueTK0Y9sSyI3lCLSx2UiejsVwW0R+wZj5xGKYUKtZ6UxyeOwk6mXFS
 63wjdRFV9KE1Vs7+gdsXdVLlfXXfx2+qupz/MK/kyYs1qDuK3wYNaHGsQuyNA0OltL5s
 yQFFMl/tjmlGBkRqyAg4XT7XD43oPkNlfhhOrNn1PDlC/QzR7B4603HnOGrSRcC2NCQt
 GbYuYkdZiwBxjs9FAFy0jCsHTjBkvUqMVYVunAmBWakEgzMq5L3zCaWpG3xfFjSXmWtf
 xGevHT0naC6iL6vasq3HMzem7IsAI6bu3npkKC1m+PdBMs0zXV9x6Z2LknNyho4U9CNX
 Q0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790477031; x=1791081831;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hajtpxF2Cztk5kuYRbyQnh/pr7a1DMFLfRCtDXBoNmY=;
 b=2YCoDgAYq+WU0g8vHsrLNoiyNzVsd2JoRzT+oCySO7+oxDvsMJdkAbgVh6drWWqGDc
 3YvhKSreMXcjqhunYgErzW9tgo4QYB8T13I6ZvlMaphYosbPyCa/a83T1NJpH2ss0QqH
 IJ4Riflsk7f4YQ2HdCJ3+Paz3dJwF7rEmKKxMmHVscT8efxXtOmHV6wXC6sSFJF2tWv+
 RIo03bSxME8jVlKr8Zp4GLEqQaZ8lbUY7hh6j6ZHJAqa3c0spFneYBMwb8wRdnbytx9y
 agtoEfnG7cuWHX7cLapQmdgDRfG9wXVLNJy5aZqb87QnCe7gbLv407DwV5h5rklDumrU
 AgkA==
X-Gm-Message-State: AFuF++klEz6XCN4TUGfkkF9cdwE2ZPqAxBkY6BmmIPi2G1k9LeXjkQyl
 tKP1YEL7eYeEqM/5nMQ2xZw4QSe3Mjl0hD1sAIt6Z2mB2W57RaSChnunyGlxb8uOH+e/GEiFray
 iwu62V369NYMe1eDO2kATjwFGM7D4P47QE8BUPzFZFvnw1eqZCjB5lvM4pvcmdlHg5A==
X-Gm-Gg: AYBFou0NGJsP0noShgm5e9V1hYnxdsLpuTfIjdVG7KoowRqsUKKTKPdYf1IyQBnYpfe
 oisVUyqoy77wFOctxLWwXBE7YWuKtLkRFy7g7pnad3yY4i9BPTsYmwbkN2RqCuJ5wtHN/6apFrH
 nP7/Wy6Zkr+9Vg0v+dI4DcMIX5WOVKY/DTKMtqgeYGOhmw5icapF4mnJRmgLR9HvNTv95VnQ6pj
 t47hRt+meXOuS8WXnDD/uXIg9ok5AXpcP3ttF6HzjIoB+QDMXmucehilycCF6QI+g69PGeJFeSq
 TTk2Kun+sK6x3UFFPGMHjIneSfuIIL9f1rinHE882IYN6iyiszKWg/iNoeRqoGSZ3LP1FhyDXmc
 kZmY0NeRr3GDfhL02E+eHbD8U86MowW83Phx/0EeOFnYKvUM=
X-Received: by 2002:a05:701b:4591:10b0:143:1bb1:3305 with SMTP id
 a92af1059eb24-146d0871d4emr4281487c88.22.1790477030413; 
 Sat, 26 Sep 2026 19:43:50 -0700 (PDT)
X-Received: by 2002:a05:701b:4591:10b0:143:1bb1:3305 with SMTP id
 a92af1059eb24-146d0871d4emr4281461c88.22.1790477029873; 
 Sat, 26 Sep 2026 19:43:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ac67c3f8sm15459747c88.3.2026.09.26.19.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 19:43:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/5] target/hexagon: emit explicit TCG memory barriers
Date: Sat, 26 Sep 2026 19:43:43 -0700
Message-Id: <20260927024347.3545385-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
References: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab882e8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=4KcYvu_XbJg6GINjK8oA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 8NTXnkFlW0vhiAISTe4qDftr1GM2Z208
X-Proofpoint-ORIG-GUID: 8NTXnkFlW0vhiAISTe4qDftr1GM2Z208
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX4jOg8NxgQr7y
 MIo0njBCE3VbD7omGYn4cRvuMdUsPnekUZ/rs+YzXZeks0i4BR2INZZwfxXGUxaqrAWRt4Z7GGQ
 mvSd0B9VqbduDK+Jn3OE/QpEw9CGriikAMmLF4nAtY/i4VSB1FHStuiUXJkIZLrmNz8UxRhTFds
 DvOOA5FlBN0r7OcsA0vbVsMzoaq53YdgHSFWXpw2RI0e9Wy8+S3eicJo4X7u+gBEiNCfXT1TUrY
 4vVJi/lrEjjTucory+Sz8svqxBPjpwNBmLQ3xFP/KYJPtggQWHyXqfZ5CqttVnkIhPF7SDLS94p
 IH+ew2fsYoDQa7cBHoT/BMgcBtNjk94GaF/TaRRpfPgnlaNjrTAkykobmmpIIQS4di0Cfl1fj7o
 5yySeBz07ci5gheZPpPV9Tzc0LMeLzbtKTTvAW2rHG1DHuS44VYGJzX58P2I9EHrH4gqR5xaHSG
 KPirLMu3zVl6JojLgjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX+qb4s8pRE9k7
 8ukOdT/HSTCEcXg4qHwojczg86U4I60u3ALSK9NYJzX70tEdUo0oxvWUfap4Inv/Exu/W8T8hsR
 3S1Jy53p7M8vMe82YgkvXkTbh3+kkOQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270010
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

R2VuZXJhdGUgcmVsZWFzZSBiYXJyaWVycyBiZWZvcmUgcmVsZWFzZSBhbmQgSFZYIHNjYXR0ZXIt
cmVsZWFzZQpvcGVyYXRpb25zLCBhY3F1aXJlIGJhcnJpZXJzIGFmdGVyIGFjcXVpcmUgbG9hZHMs
IGFuZCBmdWxsIGJhcnJpZXJzCmZvciBiYXJyaWVyLCBzeW5jaHQsIGlzeW5jLCBhbmQgZG1zeW5j
aHQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAxNSArKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCA4Mjc4
NTllMDUyYy4uMWRhZTYwYzAzOTAgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC04MzEsMTIgKzgzMSwyNyBA
QCBzdGF0aWMgdm9pZCBtYXJrX3N0b3JlX3dpZHRoKERpc2FzQ29udGV4dCAqY3R4KQogCiBzdGF0
aWMgdm9pZCBnZW5faW5zbihEaXNhc0NvbnRleHQgKmN0eCkKIHsKKyAgICB1aW50MTZfdCBvcGNv
ZGUgPSBjdHgtPmluc24tPm9wY29kZTsKKworICAgIGlmIChHRVRfQVRUUklCKG9wY29kZSwgQV9S
RUxFQVNFKSB8fAorICAgICAgICBHRVRfQVRUUklCKG9wY29kZSwgQV9DVklfU0NBVFRFUl9SRUxF
QVNFKSkgeworICAgICAgICB0Y2dfZ2VuX21iKFRDR19NT19BTEwgfCBUQ0dfQkFSX1NUUkwpOwor
ICAgIH0KKwogICAgIGlmIChjdHgtPmluc24tPmdlbmVyYXRlKSB7CiAgICAgICAgIGN0eC0+aW5z
bi0+Z2VuZXJhdGUoY3R4KTsKICAgICAgICAgbWFya19zdG9yZV93aWR0aChjdHgpOwogICAgIH0g
ZWxzZSB7CiAgICAgICAgIGhleF9nZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9J
TlZBTElEX09QQ09ERSk7CiAgICAgfQorCisgICAgaWYgKEdFVF9BVFRSSUIob3Bjb2RlLCBBX0FD
UVVJUkUpKSB7CisgICAgICAgIHRjZ19nZW5fbWIoVENHX01PX0FMTCB8IFRDR19CQVJfTERBUSk7
CisgICAgfQorICAgIGlmIChvcGNvZGUgPT0gWTJfYmFycmllciB8fCBvcGNvZGUgPT0gWTJfc3lu
Y2h0IHx8CisgICAgICAgIG9wY29kZSA9PSBZMl9pc3luYyB8fCBvcGNvZGUgPT0gWTZfZG1zeW5j
aHQpIHsKKyAgICAgICAgdGNnX2dlbl9tYihUQ0dfTU9fQUxMIHwgVENHX0JBUl9TQyk7CisgICAg
fQogfQogCiAvKgotLSAKMi4zNC4xCgo=

