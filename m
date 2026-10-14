Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA74C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2Jn-00010b-8c; Wed, 14 Oct 2026 12:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2Je-0000zA-5A
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2Ja-0001Zx-4t
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:56 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbx253644305
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f8sHOzLY27EX2ge3nt6iGcIVVcBSICm/Xh/n5vtFUWY=; b=SGTkLzjTJlMbM6ER
 eY4sDSy0InfNM9OoOOPzDRtqFg8rtYBNGkbqeIPfcr/88skpCoS06Q2MU0KlFfUj
 j9/9AIRmwKCd6ayRdEiwV6r/dE27pQvJ1YfCYv/M1oouGTQTm7DeGvy06+wnHyNW
 tiIspgU3XIn8x1solsewWIeibTqvjVInwVCAmnBr5wPM6J/+wk0RhYCdoh3/RxqO
 6NWI3ythMhec4MgSKmue9sm7FQFRb2+sVa8UoMBq9++rt+fTAcV6tGZ8v8tTPo8x
 7oWhiCejznG7BCBTganUK1jEUXNnraz3l9ZA8fSNoaAkxQisbMloUjpDvuEiFF5q
 UCP2mw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470akx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:49 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3515266f6eeso2139347eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791997129; x=1792601929; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f8sHOzLY27EX2ge3nt6iGcIVVcBSICm/Xh/n5vtFUWY=;
 b=HTKnaM+McnJZyR+3pJvkj2cLdjB5Ud6xGg2/MBKGVRwZlfmtn/prdBQtxNkMp/wci7
 P6NKhZNP/guq876apoAy3ow8hg+PfQ+ZbsvuRWQMIGl+nl8Ld8TvZMca7ZEADlx/IX5p
 ILp7AHRV9YBEedk3cEDpAhDRdMoDsfr18QCAhZXsUiycqKeHGADOceLnV4MfvlZ14Vzr
 bqRGnjY6JPsBU8nX1a2sta2BaxVFOE++4Af/yEv7l2rW4ehk7/gmZnT1JvEfv7jZfNGt
 ZkJBFx2cMDUps6wRwQ6lQ+/Wqv14yF7vD8RZ8acyQWEyHTTXZDcUEciiJ3oZox99ZFh6
 jY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997129; x=1792601929;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f8sHOzLY27EX2ge3nt6iGcIVVcBSICm/Xh/n5vtFUWY=;
 b=u3hqFapRwP2mS5937v7q+5YA5fhj/plYw7jjEIhDIV4yDGdrGmqqIp7GR2LhbSnNi0
 5JmtQXpPtZDiF1Z8GMdDUEx9dOAey3IiBKVh6ayySYrGCPe69gwAkUdN87E2Wb2Lh7m2
 Da6O3hhU3B20IpIdE8hpmSyv/ntnAnGOxaPzy4fj70LVsmRuPWGKT/oz2H3zDIbvvvmk
 FTVrmV4BciDFU2tNopM973F5d2+hMLaBH1PU3GvEsaBlr3g3mw8Gt2/0PRZfUMqTkVBp
 0TPReX7u9Yk8TaNpjunYoAMPFV3JlUD3+jEcOIwjGAP9ImfzD0q2+i4OfgZt1unZ66kD
 fxtA==
X-Gm-Message-State: AFq9FYIES6PT4ne2/XXKWVzkpSf1o2XHPBu5heovB1pywTy/57LZEHYI
 6j94njwZpiwOYyueCfqWW/yJSVM7SLVcamqSuynEXh+9Dvw5TVH6JDxTYn416asiYt5sjUs7+eA
 qZ6AbCAOFv5s6B1kBgujwlNQNUk6hLvSjvc02KAcaCTUJX0C6qjMxAceQkHUolWqSSg==
X-Gm-Gg: AYBFou02y3BDZPsuvFTZJ+Ttkqq/pY1U/lZ7d4xv1e6uDD8UvzXyMpTG1d3w8+kKptM
 +/KZ9jgfFHheF5IzQj6heo9Rfx6Pdija5ZeS+gxO4TSH2EiDe9EpakYVuYrvyTlC7lCU9s80kt3
 Zi8iGul8izhdSScuk+7l9x7fuA4iTScTHQhL3Qfzg+k+rcCCP0/R6IuXDzP+aKJN8UU/Yf9RLIw
 RAXwI93JVcRlkQ0hd7Qu02zbY3X6tUTxRPm+IosUxDNvDXuGRemg9+hJr0rHiIQiqgaG+6umbeD
 9wuScdBT7sBrRLYgUeNEhoCt5HAdSpBCEajSG6mImNnD6gGyx4/+2Fvpcb7g8VbCvYHvuX/K+JE
 qRghcRun5ls00VWto/bMMAfnnLlDg3qVdZ6xClFZ/VjOmJUA=
X-Received: by 2002:a05:7022:927:b0:150:c9c5:1ce4 with SMTP id
 a92af1059eb24-16a56ab133dmr27859881c88.6.1791997128675; 
 Wed, 14 Oct 2026 09:58:48 -0700 (PDT)
X-Received: by 2002:a05:7022:927:b0:150:c9c5:1ce4 with SMTP id
 a92af1059eb24-16a56ab133dmr27859834c88.6.1791997128078; 
 Wed, 14 Oct 2026 09:58:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm11137939c88.6.2026.10.14.09.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:58:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 4/5] target/hexagon: set a started thread's enable bit when
 start retires
Date: Wed, 14 Oct 2026 09:58:36 -0700
Message-Id: <20261014165837.2916482-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
References: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX++3SqHru6J9l
 /cHy30cDJFA9pHaxLtiT9IzPeygkqrCwlCZqopf7S/vrNqq0HPM3lAay2jU9/QLAuAgPshTE+2z
 nzblI921yi3vIr8aYAbpCCFGhb0sw0859PAgeftDK18nXue54AqAoqufVMHQbmbTZU6OmoJExkY
 lKx/D0O8zE/ejFrcqciuI48twNt0SqyZaMgPL/R3xGcc5KTq4C/E5e4zGI0g6E600sqNwQaJWPm
 4tiQCZePRQ5L2ROp9jOyvISKCHzdo6hUJMWbZcGA3bjHj3Da/xe7fOclX3YRgrbmSI3i4747XvJ
 VGIWCdGBxr13nTmN3NSbU2CiD6pRAQNNyfXWsICx7iawIVxkVlW202krXBmi5Wo4OYj8PdNXu1g
 bX2ohsWIbMmoLWjv+hlCvjg0ZPDavnevUgwE3C3kHUlt9rqcs0ownfeQ+LrLk+yiUY3L/zP3S4y
 1J0GQfTFnjRKFlIVQkg==
X-Proofpoint-GUID: cMqdJKXfd1p15evqlLpi8nQ9DaAGjfZn
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfb4c9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=u35ek3RR3RME6NZFTgcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: cMqdJKXfd1p15evqlLpi8nQ9DaAGjfZn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX1S/pi60dlNlG
 ASpmA23BSEi587AnxEo5bBqW7U6wfg3PCR/bsSSrR0Qzaj0v/zDdh1ePK94vwee0cq5gO8qtJKo
 9OLy1yx69ZFgkwdRyLMg+EsDd7Q5Hwk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140067
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

U2V0IE1PREVDVEwuRSB3aGVuIHN0YXJ0IHJldGlyZXMgcmF0aGVyIHRoYW4gd2hlbiB0aGUgdGFy
Z2V0IHRocmVhZCBydW5zLiBUaGlzCm1ha2VzIHRoZSB0aHJlYWQgc3RhdGUgdmlzaWJsZSB0byBz
b2Z0d2FyZSBpbW1lZGlhdGVseSBhZnRlciBzdGFydC4KClJldmlld2VkLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6
IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4
YWdvbi9jcHVfaGVscGVyLmMKaW5kZXggNGU0YTgxYzE2MmQuLjY4OWY3OWNhOTM0IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
X2hlbHBlci5jCkBAIC00OTYsNiArNDk2LDkgQEAgc3RhdGljIHZvaWQgZG9fc3RhcnRfdGhyZWFk
KENQVVN0YXRlICpjcywgcnVuX29uX2NwdV9kYXRhIHRiZCkKIHZvaWQgaGV4YWdvbl9zdGFydF90
aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqY3VycmVudF9lbnYsIHVpbnQzMl90IG1hc2spCiB7CiAg
ICAgQ1BVU3RhdGUgKmNzOworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKwogICAgIENQVV9GT1JF
QUNIKGNzKSB7CiAgICAgICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CiAg
ICAgICAgIGlmICghKG1hc2sgJiAoMHgxIDw8IGVudi0+dGhyZWFkSWQpKSkgewpAQCAtNTAzLDYg
KzUwNiw3IEBAIHZvaWQgaGV4YWdvbl9zdGFydF90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqY3Vy
cmVudF9lbnYsIHVpbnQzMl90IG1hc2spCiAgICAgICAgIH0KIAogICAgICAgICBpZiAoY3VycmVu
dF9lbnYtPnRocmVhZElkICE9IGVudi0+dGhyZWFkSWQpIHsKKyAgICAgICAgICAgIHNldF9lbmFi
bGVfbWFzayhlbnYpOwogICAgICAgICAgICAgYXN5bmNfc2FmZV9ydW5fb25fY3B1KGNzLCBkb19z
dGFydF90aHJlYWQsIFJVTl9PTl9DUFVfTlVMTCk7CiAgICAgICAgIH0KICAgICB9Ci0tIAoyLjM0
LjEKCg==

