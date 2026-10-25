Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BB606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RwgYAuf+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ffnrv46+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKos0-0000oB-JS; Sat, 24 Oct 2026 23:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKorD-0008SR-OH
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor8-0001Xn-Hp
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16lkU2570155
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=; b=Rw
 gYAuf+uZ21oIpzNn2+FJuCfzydZIBW7JrhCyyKesUpoG/z5f3z3ohiRuCs7I6JZI
 WH0HfhpDQeUAUvbj0xPgfk29XnGTkTej96fMuJkGWc6jrLLxRbDnl39bRrzQGF+s
 abNx91CQrFdpcFoMsQs7el0BvuoD6ySBT3rDW2Y0roGCQqTP7cpEWXV6B97WLNcI
 eR3QNbSpMVlsSYT9g8CjL/s10UpqpugZesu/eATSIcj79D2zKPetQsJMuzzK2i0i
 vcuyTRA6icAgpP1zPs8thWGoes3j5w9OZXnVElEQZJtG6g4/iE5qTv1cK7ExfoWL
 pX17FGhiDQvSB7fqleAg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehj80r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3580c07911eso6463693eec.0
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898698; x=1793503498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=;
 b=ffnrv46+mcQNpBk5L/cle+XMLMDJcLm8+2+73ZNhXOqdS3o05VKwE/JJk5ZgE3Kd5b
 daR8BXn3G26kBZaAtcZFuRjMo6aRDiansAo7sD23tzOp/it6eWfm010O0IQl31FU+4bZ
 qeiYrnKquTcix0lq5hBqL0G6UFPbcG3w4epWSGfYYw0wFhyOKipoGihR5Qn5sLS4202U
 csiOEFpHN2Q5Edpm50kAqh70AWpBKAVLEYWS7lLN5wbGZwwsmsO2BeOTeWHILGJ7tV8X
 9h2A2H9vg32MvCEdeTkvVVotw5Kd9ltijhggrR0Or3DfVYUUXENmB4TsDegNOEoi32an
 DTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898698; x=1793503498;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lxHX48m9MhmdYDkUsHmXuQZ8n9DQadgazK3dbyAGTS8=;
 b=2uiTBcubz5uGj7qYLd97zOSYrzdop6Xp5Y4bDzteewnyK7jvplkQ9huagMSyT9uNad
 LC8O3vnbYp25NNKcs0V2AlOZRNXZ+jc9A+VAg8TAjg/+h6vXtcnfLK6y7AySX1NfzWOp
 S9qx61qjVN37kOcOAQ3po0TzsebsGRmtlpVaXeAd0q7Ik+EqtEkt5l5JprJl5nlzsuZF
 M69/nP3vN5jIq/7vsVtbkngJ1nTMmWjEBLW1FWwNVi9eDuajTUaRktqIOS+3PkKYlADd
 laWuwU1UvRyC6a5YXqXRMkZpuwIK56qwQgJCukZfqoW1GdyYOcdDvvtkTfaH5A9HXHHg
 sdLA==
X-Gm-Message-State: AFq9FYKzV8S4/OkxlTMHDZcEx7Q4jqUi8f3l9NCKUPD3qM+6FftKUM1T
 HBBYAF2P93Gjaw6YFgl1XT8bfFeq9lIwD3MCpEAOEvlzWNUC6G1T0ZI5qJ9oXhEJdzPzO8pJ0Qt
 2klBuCqPZecy4RE8uXj/w8o+k6MIU6RokKlYONT1roqEROF6jPzCSm9hnRbZgGcJ1Ow==
X-Gm-Gg: AYBFou2xkcMQ5MiDxwUKzehZIBktFdrxAQxdtsmKyOEKvSPvZsQ3XprrQFriJxudwKr
 qFU2EwPdZJ5TT6Lo6XKYzMoh1XmFTUo0S6nl6YNex7LyltMrb3ZuAfDe7W1bcd8nG5FdO+r/OtS
 /UqbI2WHQ06xQMckeAtTF77dUImOD7JxOSVt9rxm5Po3wtLexikkwZhJr3pTxeDs6JdrUDXQ5ov
 RR8AvSk4uBanGlARWoeonC8mWXAD9lyO9EYkijytxnyFsnW07zz6vLrK84I+95TUHF1mg6Z7PfU
 MBkmBs5T0NjhubL6OdvSKFuHVHjJFHRMXN9Ks/JhO27TKghzrKSIGFkVll7FDRgeZAXL/XtaKQS
 akj/gtdRFZ8FpV2of5uZ2B7CGgfwxjIAjk9KjWyEzQsOwMYs=
X-Received: by 2002:a05:701b:464d:b0:18a:d7db:f76 with SMTP id
 a92af1059eb24-1993fe81371mr4439290c88.36.1792898698374; 
 Sat, 24 Oct 2026 20:24:58 -0700 (PDT)
X-Received: by 2002:a05:701b:464d:b0:18a:d7db:f76 with SMTP id
 a92af1059eb24-1993fe81371mr4439272c88.36.1792898697816; 
 Sat, 24 Oct 2026 20:24:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 37/40] target/hexagon: avoid negative slot shift
Date: Sat, 24 Oct 2026 20:23:43 -0700
Message-Id: <20261025032346.2917451-38-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfX+Ey7qhF2Ru+t
 H7dP/VVD0c9cx5TOXj/0c6P27KDKTAyJUAlkPsdQgdHHNOYTKpLdOmsYVPt2zNwxRzt0rIDY5qL
 2O9qKcyLqryY1vOrPASbwLngaNXryeY=
X-Proofpoint-ORIG-GUID: H30XB5YXpewYOQf0jKGnTbprudynNbNM
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6add768b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Kwhbg8pJGtqcix1HUGwA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMyBTYWx0ZWRfXzj+McxJgQcz1
 iUuafeegFAWgvWrPcxYRe83zZzeiRP739HTROMP4aDVhdSmdB33LwWybcrzLAWsPIApQST6uJLx
 bmPzgcaXTYgQNaEuZpqE/Qjjv0NhGF+1NfD0ko3wZSUbdq98uXXtiNk3YOqffthGmsI82GacBT3
 Ad42VgFnJt/Axll7ZWxPEdPuV8PODz1ShWuV+EqI/Qzh3johE134r0Iev0BrGsd8S7vpEQ7ymLT
 8dAvrMjZYoFYKJB0gkFSF+W0jK+5Ha/TRZNRWuUP5tRfdsTw9Ik0xpc6z/H3peZa5z+9egymv6L
 ElgPyNjoZZmfSp5KBzmCdhva7UxQh+f2/zGRk2zUkpd5NSR1Y9pyxofd0+3W/OY8Ztb+BvATu5k
 89B+yOHVQu9XQGft47ZYBRQxE16hajr0E/9063vu3K0IdI49F3K5OtkXMrXOp4ZAxSN1VNEOM81
 rGQHAUPRa+fG3NAV/GQ==
X-Proofpoint-GUID: H30XB5YXpewYOQf0jKGnTbprudynNbNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250013
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

SW52YWxpZCBwYWNrZXRzIGNhbiBleGhhdXN0IHRoZSBhdmFpbGFibGUgaW5zdHJ1Y3Rpb24gc2xv
dHMgd2hpbGUKZGVjb2RlX3NldF9zbG90X251bWJlcigpIHNlYXJjaGVzIGZvciBhIHZhbGlkIG9u
ZS4gIFdlIHdvdWxkIHRoZW4gdHJ5IHRvCmV2YWx1YXRlIGEgbmVnYXRpdmUgc2hpZnQgYmVmb3Jl
IHJldHVybmluZyB0aGUgcGFja2V0IGFzIGludmFsaWQuCgpEZXRlY3RlZCBieSBjbGFuZydzIFVC
U2FuLgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9DQUZFQWNBOENZ
YUo9akF5YzI5UlNkVU1EX1NXcXVKcXo0Zk5ReVc3b0NyV2l0aFpoWUFAbWFpbC5nbWFpbC5jb20v
ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29t
bS5jb20+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyB8IDUgKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4
IDM1ZDc0MWNlODY0Li4wYWM4N2JiZWUwYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZGVj
b2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKQEAgLTYwMSw5ICs2MDEsMTIgQEAg
ZGVjb2RlX3NldF9zbG90X251bWJlcihQYWNrZXQgKnBrdCkKICAgICBmb3IgKGkgPSAwLCBzbG90
ID0gMzsgaSA8IHBrdC0+bnVtX2luc25zOyBpKyspIHsKICAgICAgICAgU2xvdE1hc2sgdmFsaWRf
c2xvdHMgPSBnZXRfdmFsaWRfc2xvdHMocGt0LCBpKTsKIAotICAgICAgICB3aGlsZSAoISh2YWxp
ZF9zbG90cyAmICgxIDw8IHNsb3QpKSkgeworICAgICAgICB3aGlsZSAoc2xvdCA+PSAwICYmICEo
dmFsaWRfc2xvdHMgJiAoMSA8PCBzbG90KSkpIHsKICAgICAgICAgICAgIHNsb3QtLTsKICAgICAg
ICAgfQorICAgICAgICBpZiAoc2xvdCA8IDApIHsKKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsK
KyAgICAgICAgfQogICAgICAgICBwa3QtPmluc25baV0uc2xvdCA9IHNsb3Q7CiAgICAgICAgIGlm
IChzbG90KSB7CiAgICAgICAgICAgICAvKiBJJ3ZlIGFzc2lnbmVkIHRoZSBzbG90LCBub3cgZGVj
cmVtZW50IGl0IGZvciB0aGUgbmV4dCBpbnNuICovCi0tIAoyLjM0LjEKCg==

