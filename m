Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8C2C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9b-0005AA-40; Thu, 24 Sep 2026 21:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9Y-00053x-C8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9W-00065Q-5R
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kVVt4051919
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aV+mAcO8jRn0u+WfEX2FJKrucWSrrnbTCO2zRkrEfqQ=; b=br8PbQszYzrB4PKv
 rTep+zPn3pcAame9O1nmzf1lBLQc6AfD9qXis6keTtN8cl4gxS0UwwjWkVpSr5vI
 QfJ1bB5bMZ8ADSqwD1L2RinHyFdnImmSysVArx0ttWnsIChwhmRWOLVP+KqiFKHq
 yY6kaQgHUR501Wr5tk89qHrdRfJQH/G3DO8rXIoE/VrjzofvoiVXARDyItpMF6+b
 IPbByX5zT0QKEg4yem3KQS3r2tTJf9nUZfLwLgcsgiOdVcH9a5x90SfGRPUiYjPB
 4nGanv1sJTFKjtdRF0Lp/UyYql1aVhXI5xq9S40kQVOpautbjL6c9le7Mz3RhRnU
 IGwiFg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898skgk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:04 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-32861f5448cso1379729eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301304; x=1790906104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aV+mAcO8jRn0u+WfEX2FJKrucWSrrnbTCO2zRkrEfqQ=;
 b=VEVUj+tB+7BIpN9orqFUheEkgza15bTl4gwEnAKq61VTbKZfIJWJ7k1kjWXV9qPbtr
 fQ6tX/Y9UcmSgqmEehI5PPBz1v7l2Pdg54WLi6mKDTsyVdGfJ2KAStY+sgKvnMU+LseC
 K7JMTIKJF/9EXPytfW4QK0kMZNtyhCY3v7P43JtiaebErFu6Yz4FJfwM8M1oGo/K35QF
 WoP3JKR+iosmnrxI48DETeNZ/nMDYyEqNebPuBEcB4aKQaIiDq1eWOsyJmYUo6tZTLjF
 r0x6BcBktxjBSdOPlYvydwtv16XEsitzwd+/cy4LFxIoSnrHVlSn4cdcbb55B0a7ocy0
 nUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301304; x=1790906104;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aV+mAcO8jRn0u+WfEX2FJKrucWSrrnbTCO2zRkrEfqQ=;
 b=VTQHRwyPrfmIRDNzvkQDyWVn8Bo20kUDra3kjFhFdCaszWbVM9NE9FDwG5rHfa6wH8
 ERcH/BEjrA+h5JgzCIpbV6r8mCJ9/kaTTrWzJDXFoxtwJqY/aJ/4K1JkD/z/7+dP+2gB
 NpGJb3F2KK63IbcYw1gkWITwCT7VzhVjzIOcOuVKEqtWsHsDDm5cPnFqlwCfJF/BHoxf
 0eFcqs0MrFM7TrI4scaYNzp8l+zdRL7jaTww3nUGNciiI1GSxcw2QbGxvIkgO8zZVAtu
 wDjJ+liwFG8fMw7TGhi5oaPuJM5gtQ+j4Ubnil+AWObM46om5Dy/PGkEF+KSYDQGMpiV
 lWnQ==
X-Gm-Message-State: AFuF++nRPHpVSdpQNu7DxVZjK26sVJE9wnxbDxPBxoGKOOI1mKX1Rzre
 4+bF3nN71siUmJ0spLElZxXsFWy3BRq3OHiIMhvg6ErCutujvEJz4+7eCwByaXXdnd3PHZeJbKH
 qnRnHoxOu9BAWGaN9GLzc1LbCsQ2Aidtp8FsI3lF0LFNAtIdZE3vkXHapa727KDnUkQ==
X-Gm-Gg: AYBFou3jt6QX+HNYKK6uQyj8HiRS6a8zYm5qlaiLU6DhOLS1Fjt+VFv75lnENvLn7Tp
 CssT+vUUd82yOqQkS3rfCsaLGFeuHx3ryhBWEEVyZy6i33xM8w5i41SGzYeBjInHdN6rkLuCC5J
 1kBEQw2sQ3gqUTUi+EP3Ual/R4O+kLa7lIW/Lo/QNRH7oycfU+nySp2l9nhWdxBCirziOWZwF6y
 3ZS7MGIaTCNWSXuCFDCV+ljfZX2vE4kThFr8s44TJg8wXGpaHFBp3T1IEaygM/C0O1yJ0F9YYp5
 9l0DOma0MxEcZr97b1bJv3uI/KX6bNcdi6jXQNT3kRTPmXYr9N+mN7gg5Uaj77cO/v9jDYCE+7Y
 yp1hPHuMjFzLOIrQLZabRXXDxq+n1gwXa4Ot9sXZNpbeqkxc9cksw62yM9Q==
X-Received: by 2002:a05:693c:87d8:b0:33e:bbcc:eb99 with SMTP id
 5a478bee46e88-34001eff31fmr2884138eec.18.1790301303615; 
 Thu, 24 Sep 2026 18:55:03 -0700 (PDT)
X-Received: by 2002:a05:693c:87d8:b0:33e:bbcc:eb99 with SMTP id
 5a478bee46e88-34001eff31fmr2884124eec.18.1790301303031; 
 Thu, 24 Sep 2026 18:55:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sid.manning@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 19/40] tests/tcg/hexagon: add dczeroa cache line zero test
Date: Thu, 24 Sep 2026 18:54:08 -0700
Message-Id: <20260925015429.2579174-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXzcmEqyN2b/Nq
 g8mrI4l2riZIrpY89agKLGjUwFsh6hZyGREp362HLhiWvNq/75rBe2JAYYJVS87gNRG7vdw7dMH
 Xnqu6P4hN+CY+Jr8ksuA1FajTW6kHU+RDLeNpJ7E7C/1aSb1k3lb63O6OGTMZOxUu5FFAP8r8Bp
 L9YsOUMhwbaVS2KON9jQ3cmmfOq8WgFtpaKm5BVUYxcLE5kSlSoIE2cY2ZkYbhXnuZ2q9ijLIUt
 qYZYMoS6qpZNugzr/Z3Nq/KRT0TpySWGqnzts9nR08MEgA7dxzoGg0P5dKKwctQbwC58xVPDfrP
 suuuFQmG0Yp08f+RDImFd05N4Q5KzXC2ySXvBRGhtuN1bZXB2K0yfqqpq26vWm85sqIy9g3WQK6
 MbYjW+Dgiil9ZzH7+x7snVsrML8/rmBZS7oqh5O9MrDBW2yur4QkV4CHGkDDYGB550pa6bQ0J5R
 lUCdSZ70vgQdYKfNz7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX1UGRdF01Yoa1
 lm7WjTQGmomIRF3jEnfDWnMW/1gKvSKkeyABEKSuaGK5yaNsjwLommiKfJfyCbn1Ou2JmLQI1d8
 Iyb96atgGGeICjXkIL5lUNySt60ZE1w=
X-Proofpoint-GUID: A3-387mkrjXCPvFh6piiwaGzssE7ZKrC
X-Proofpoint-ORIG-GUID: A3-387mkrjXCPvFh6piiwaGzssE7ZKrC
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab5d478 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=StvKSay-7vg8R344wSoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGVzdCB0aGUgZGN6ZXJvYSBpbnN0cnVjdGlvbiB3aGljaCB6ZXJvZXMgYSBjYWNoZSBsaW5lLiAg
VmVyaWZpZXMgYWxpZ25lZCwKdW5hbGlnbmVkLCBhbmQgYnVmZmVyLXN0YXJ0IGFkZHJlc3Nlcy4K
ClJldmlld2VkLWJ5OiBTaWQgTWFubmluZyA8c2lkLm1hbm5pbmdAb3NzLnF1YWxjb21tLmNvbT4K
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIHRlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5jIHwgODggKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgIHwgIDEg
KwogMiBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdHMvdGNnL2hleGFnb24vdGVzdF9kY3plcm9hLmMKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cv
aGV4YWdvbi90ZXN0X2RjemVyb2EuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5j
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi44Y2RjZGQ2YTNiNQotLS0g
L2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL3Rlc3RfZGN6ZXJvYS5jCkBAIC0wLDAg
KzEsODggQEAKKy8qCisgKiBDb3B5cmlnaHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5j
LiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBH
UEwtMi4wLW9yLWxhdGVyCisgKi8KKworLyoKKyAqIFRlc3QgdGhlIGRjemVyb2EgaW5zdHJ1Y3Rp
b24sIHdoaWNoIHplcm9lcyBhIDMyLWJ5dGUgY2FjaGUgbGluZS4KKyAqIFRoZSBhZGRyZXNzIGlz
IHJvdW5kZWQgZG93biB0byBhIDMyLWJ5dGUgYm91bmRhcnk6IChhZGRyICYgfjB4MWYpLgorICov
CisKKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPHN0ZGludC5oPgorI2luY2x1ZGUgPHN0
cmluZy5oPgorI2luY2x1ZGUgPGhleGFnb25fcHJvdG9zLmg+CisKK2ludCBlcnI7CisKKyNpbmNs
dWRlICJoZXhfdGVzdC5oIgorCitzdGF0aWMgdWludDhfdCBidWZbMTI4XSBfX2F0dHJpYnV0ZV9f
KChhbGlnbmVkKDMyKSkpOworCisvKiBkY3plcm9hIHdpdGggYW4gYWxpZ25lZCBhZGRyZXNzICov
CitzdGF0aWMgdm9pZCB0ZXN0X2RjemVyb2FfYWxpZ25lZCh2b2lkKQoreworICAgIGludCBpOwor
CisgICAgbWVtc2V0KGJ1ZiwgMHhmZiwgc2l6ZW9mKGJ1ZikpOworCisgICAgUTZfZGN6ZXJvYV9B
KCZidWZbMzJdKTsKKworICAgIGZvciAoaSA9IDA7IGkgPCAzMjsgaSsrKSB7CisgICAgICAgIGNo
ZWNrMzIoYnVmW2ldLCAweGZmKTsKKyAgICB9CisgICAgZm9yIChpID0gMzI7IGkgPCA2NDsgaSsr
KSB7CisgICAgICAgIGNoZWNrMzIoYnVmW2ldLCAweDAwKTsKKyAgICB9CisgICAgZm9yIChpID0g
NjQ7IGkgPCA5NjsgaSsrKSB7CisgICAgICAgIGNoZWNrMzIoYnVmW2ldLCAweGZmKTsKKyAgICB9
Cit9CisKKy8qIGRjemVyb2Egd2l0aCBhbiB1bmFsaWduZWQgYWRkcmVzcyAoc2hvdWxkIHJvdW5k
IGRvd24pICovCitzdGF0aWMgdm9pZCB0ZXN0X2RjemVyb2FfdW5hbGlnbmVkKHZvaWQpCit7Cisg
ICAgaW50IGk7CisKKyAgICBtZW1zZXQoYnVmLCAweGZmLCBzaXplb2YoYnVmKSk7CisKKyAgICAv
KiBBZGRyZXNzIGJ1Zis0MCByb3VuZHMgZG93biB0byBidWYrMzIgKi8KKyAgICBRNl9kY3plcm9h
X0EoJmJ1Zls0MF0pOworCisgICAgZm9yIChpID0gMDsgaSA8IDMyOyBpKyspIHsKKyAgICAgICAg
Y2hlY2szMihidWZbaV0sIDB4ZmYpOworICAgIH0KKyAgICBmb3IgKGkgPSAzMjsgaSA8IDY0OyBp
KyspIHsKKyAgICAgICAgY2hlY2szMihidWZbaV0sIDB4MDApOworICAgIH0KKyAgICBmb3IgKGkg
PSA2NDsgaSA8IDk2OyBpKyspIHsKKyAgICAgICAgY2hlY2szMihidWZbaV0sIDB4ZmYpOworICAg
IH0KK30KKworLyogZGN6ZXJvYSBhdCB0aGUgc3RhcnQgb2YgdGhlIGJ1ZmZlciAqLworc3RhdGlj
IHZvaWQgdGVzdF9kY3plcm9hX3N0YXJ0KHZvaWQpCit7CisgICAgaW50IGk7CisKKyAgICBtZW1z
ZXQoYnVmLCAweGZmLCBzaXplb2YoYnVmKSk7CisKKyAgICBRNl9kY3plcm9hX0EoJmJ1ZlswXSk7
CisKKyAgICBmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykgeworICAgICAgICBjaGVjazMyKGJ1Zltp
XSwgMHgwMCk7CisgICAgfQorICAgIGZvciAoaSA9IDMyOyBpIDwgNjQ7IGkrKykgeworICAgICAg
ICBjaGVjazMyKGJ1ZltpXSwgMHhmZik7CisgICAgfQorfQorCitpbnQgbWFpbih2b2lkKQorewor
ICAgIHRlc3RfZGN6ZXJvYV9hbGlnbmVkKCk7CisgICAgdGVzdF9kY3plcm9hX3VuYWxpZ25lZCgp
OworICAgIHRlc3RfZGN6ZXJvYV9zdGFydCgpOworCisgICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAi
UEFTUyIpOworICAgIHJldHVybiBlcnIgPyAxIDogMDsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3Rj
Zy9oZXhhZ29uL21lc29uLmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5k
ZXggNjA3NGU1NmY2ZDYuLmZmM2MwOTVkOWNiIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdv
bi9tZXNvbi5idWlsZAorKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNzQs
NiArNzQsNyBAQCB0ZXN0cyArPSB7CiAgICd0ZXN0X2Nsb2JiZXIuUyc6IHsnY2ZsYWdzJzogYXNt
ZmxhZ3N9LAogICAndGVzdF9jbXAuUyc6IHsnY2ZsYWdzJzogYXNtZmxhZ3N9LAogICAndGVzdF9j
b25kX2JyYW5jaC5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAorICAndGVzdF9kY3plcm9hLmMnOiB7
J2NmbGFncyc6IGNmbGFnc30sCiAgICd0ZXN0X2RvdG5ldy5TJzogeydjZmxhZ3MnOiBhc21mbGFn
c30sCiAgICd0ZXN0X2V4dC5TJzogeydjZmxhZ3MnOiBhc21mbGFnc30sCiAgICd0ZXN0X2ZpYm9u
YWNjaS5TJzogeydjZmxhZ3MnOiBhc21mbGFnc30sCi0tIAoyLjM0LjEKCg==

