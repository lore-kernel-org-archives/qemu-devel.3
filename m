Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC0CCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbnd9-0002sx-Gf; Mon, 22 Jun 2026 19:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnd7-0002sP-BC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnd5-0002S8-Ss
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaxJ71902562
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=; b=RzBnJ8SlAcGS/meX
 nLRpKtSYLxcxeaW8esFRJIzQ7UfZVLtbLJYqwe78nyDPSA21HE2TscN3x+PGtu3Z
 qojSKJp8EZZYplxKmAYp7sJdG/Z4wNm8IU0Qlv0phR71/piYVJtcu2cE40IjHGUE
 ccgJuX/1roOHdtgJgej+fgyc/Jce6zLMcGmZVUvcX14Dxoqym/wfSJrWaZoYVgWr
 4wAuZi927yr5RrkDr1N3TuE9NESygVNEI3GhN3non7uE85A/MAZtxuVwhjCRsBNJ
 09UFoM8Var0zxkEno4+3a5pCHYY0IHDFP7NFXF/+G6+aP5uIjYcO00RALbmWpKn2
 c41MXg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1unfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:24 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139af2bd2c8so2432970c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169224; x=1782774024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=MoY88S+GjngORs1Jwb7Lp0G0eh03ocq0GQhkRRG/BhHx49Z2nYHAFKxyoPaP7Tp193
 Mk3goquZ43LOycQZb6ePTBZsxL64eqha+wNF4DQvoVeQsriWMMX+sttRzCOuQBzZT/3p
 MvyrS9mIAMVi3i6R4UDnYKZbAAj/9vm68eDpKNGDOtKy2QkrG6EdeoJ3aacnFd7m7GpP
 aB9xA39Lru3eM34Q5A9lRKJMX8LOv6HcsQwrnIk9bI11lhj/Z4X+LzPASRDphHW8oHa3
 VlrW++pU5rHYrqHUJqDCSsWPkaV1YFHIf0JgEAKcaCt/E1taksk1RkXnxnu8Mk/a5s22
 dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169224; x=1782774024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=cpUA43xskaogrA34gXZTUssiGwPX72Bx9xteYApxD24s3TVGOePGgO9ceExwpgRewT
 HWEPE17AyOJw4kDcy62NN7wtgjddkn1SUQHLVt2dJNrivrmgP6aSBRxyFwIiO2grL1o2
 S6Fud6UqckAScm16f/7yipm398fIe4dcpCNnfjcng3dFMT2p7eoDJoLmTkIgQZxJs50v
 /8u27lo46MggbcLowSAd4NA+CiBPedN6tu/n2hl8jqk9lOKiGqJWb5jvvCNCPjtE+Rlv
 g8dztkgV7l8cQAk+GeTSqDg3SWTpbJupfVxKEFEcwBq66rH0swE9vFEyYeGElSMn+K7Y
 Mmyw==
X-Gm-Message-State: AOJu0YznwlyCNhJdjX56t2Y07DZjN+HeaCTNs16E5zJJiM5v4PukF2Ey
 yHKLskIQLZzY+JyAe/usp/3vBWyuljEAPb0aK0uc09H/otHyCa+aGOJNcR+RdH+DzeupVcCCXJ/
 PqS/in0R+dIHcZ8dwXj6odfFkm0hI4rxK7zaIqncjTladqX+/lYGx6PzZfcak5WOEpQ==
X-Gm-Gg: AfdE7cm1A2mRFRLEbK7ocrrikVxQUvZvfHZVUdBI/TjtWjC8PUWq5+ll1x6FvxNl57K
 T38E+N9YnDvKSo3qmuwj7aTkxM8TKDlzwQJOuRVEjrAwdY3BoNbBnhtJDpIxTh63t1ek2sy21EW
 uorY3+ZEQKN+aMO/bHvURaFJGeKuytlUJCkJrlutOy0+SBQ1J39C0wmcIRMlXajLqB13hHp1Ed4
 Em4fWTnhjW18qwFK7RsEnJBEkrfAj/Y6LL0JROKfvAujUxiBy6k+ojT8Om05nSUtUq79c85MjVI
 x5P6iQ714EdtVGM793kVxtkURwjFsEfyUHCJu79cjjxw3CpNV3qJ43UdISHSt4MiVYzCpDg2ooQ
 9s+22flVAHLYTxMBc14q+xilzEmpQ00a4vObfLtN+RploZ0T1iZXytUPALso=
X-Received: by 2002:a05:7022:45a4:b0:127:3f2a:af21 with SMTP id
 a92af1059eb24-139c5cff378mr334079c88.15.1782169222904; 
 Mon, 22 Jun 2026 16:00:22 -0700 (PDT)
X-Received: by 2002:a05:7022:45a4:b0:127:3f2a:af21 with SMTP id
 a92af1059eb24-139c5cff378mr334047c88.15.1782169222210; 
 Mon, 22 Jun 2026 16:00:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 50/75] target/hexagon: Implement siad inst
Date: Mon, 22 Jun 2026 15:28:39 -0700
Message-Id: <20260622222904.607771-51-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5Tq1zCLQ6NtCZNttGEFRY57LE1xdh8GZ
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a39be88 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX0Y5O5X0ZbH5N
 zU9Uy0SfohaUSuxJZfOYRP1XDl/dDrpFSMtzh68/fLjL9NVcFYew6U2ZNo57d8e0AadQ0Y6kWS2
 C6s80VYrc07wOSkOGOGxGb/nrVTNCko=
X-Proofpoint-ORIG-GUID: 5Tq1zCLQ6NtCZNttGEFRY57LE1xdh8GZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXwREqewkxtbv1
 B5UqhgUlwGRbHzC4rkgm8wPlI0L4IzNfEe1rMSPuPnSsWGnaYiWauDmoXimGryAFntymj3dWnz6
 /qXD7UwtrRL2cYT9PrSv8GSguI9m+Mzrrf4tT945q4l375a9kFyb24CH0LimVKdUH/ni5rtM38O
 kMLwEuChnxNXZocAJU2TW7O0g/6o6Nk06u/QWb/lU/kp+dLvtAjZeaJX4TgPL194+toRvadTLAz
 56daSZJVyqMgijYQLySMs4YCSDwyEBEYAsQYAnxOKXTiwt9KNdif8M8AEAodnYzzLxI9XnDwUga
 PBK/2OWT43N4BMByzgMs3cIl014qc4HnLt179MsQIrtN59tOW2Dcz7xhkpysnUkcWK7UOBGFR/h
 EMxq0KUgkv/vfnCUBDY17XZ1NNJyXfNfOhZjcX+cKq9yzCxenaYl8mBC8OVQ8PAXFGrc62LILNU
 qWIpApQBeAYo66kwT2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggYThiZjg5YWI5OTYuLjRk
MzE5YTI2MzdmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQzNiw3ICsxNDM2LDIyIEBAIHZvaWQgSEVM
UEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQogCiB2b2lkIEhF
TFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKLSAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IGlwZW5kYWQ7CisgICAgdWludDMy
X3QgaWFkOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpcGVuZGFkID0gY3B1LT5nbG9iYWxyZWdz
ID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9T
UkVHX0lQRU5EQUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCkgOiAwOworICAgIGlhZCA9IGZHRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQpOworICAg
IGZTRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQsIGlhZCB8IG1hc2spOworICAgIGlmIChj
cHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5n
bG9iYWxyZWdzLCBIRVhfU1JFR19JUEVOREFELAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpcGVuZGFkLCBlbnYtPnRocmVhZElkKTsKKyAgICB9CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKIH0KIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKLS0gCjIuMzQuMQoK

