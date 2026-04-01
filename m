Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669E610F6FDC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xcB-0006dM-Ey; Wed, 01 Apr 2026 11:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xbL-0005zC-CI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:35:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xbI-0001Q0-Jb
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:35:27 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631CS2BK1285859
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=8H2NMNnhou62pXryHwuyymxk+qlycrZjxUxVfNu3jeE=; b=JY
 Bd8KP9e6OKgKZ6dMBzH3vYrE3MbHa7M/BXSl71fwfLfAwMXwsarvJXvHspfOGF2n
 PpEzwPpe3Cc1vSPZmEhCtnY8OuoJY2UUKzkQB+UmIlRD3vqUmFLIUmIRwGb8Nwcn
 mbC0HET76TPs9pYB9df6yLutPpa3LLK8PHliTLrU4pGFe8XPb/+SuGwMVJmSeXIA
 ho6ZXZOXccfbJHNnM7oMaP83z/SpYu3pFYGjgeuWchTQ72JDuRyoEyp8QgM11fmY
 GXdA1nwRFNGlaDjg20555mVRi/cR9P9bWlyDePknOl/a4OX+RDVBA11ajit64/yP
 JdNN7FTrTlQy0+0MjeLw==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8xm3t4cx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:35:22 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-65014989b1eso13895402d50.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057721; x=1775662521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8H2NMNnhou62pXryHwuyymxk+qlycrZjxUxVfNu3jeE=;
 b=JKT516BP9Ve6w3C3Dg49a05G+5Q+OaTS/BkLIrVuOmfBz6LjOonzG8rL4VusCDRG1T
 h5stfWCu2tBXMOed/YAnT9l8M51vySmjOOMclvWkmc1UEE3Ev2KknnC+1omBgObAqKVl
 bOiwUBjvlbLII8siCts4QmIZZAob0JP01H9r2W85OldVMHMgYAnYbbLIN93J3rIJtcEV
 cXpGvB/nV48/yqyDIs26ScUo7ichrbe4BrxeUxkTNQchA+jM3OETKzpez9sraxH/f3HD
 GejU/MfAqvYv2RSbJz9AVTaxurBEc288DSQu3dINe0mrvJlg20LWIPNl2cA20fKVJALQ
 Rtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057721; x=1775662521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8H2NMNnhou62pXryHwuyymxk+qlycrZjxUxVfNu3jeE=;
 b=LqTNsFYEnSf+37vdK8qcOXWcWa2CXCajBt48MLkQA8gO5YNIPKFDbzWdPKLESDZqvx
 oQWlaeUWeFSZ9/6dXiGJoD2CDRIFeBhP/M8FLGq5SZ0AgXhWTMpa+QjgUa5LiE+v6G6z
 /uSoMpBTGctBy9uTXDA7MALSquA3vJA/dfNUfyyunztHGfVSbq7vOXB7AKv02yVQSWQN
 aNZt5QZ/qBvxpFKwBFZ7JQXb93Pu5v3PPTwOm/LounPytqEYHGEk9iGU1WryBcni+OtJ
 ZpqXG9lC+jTT5+5JoGclAySpgi3krqBWrPACZCsOSaAhBpOm5u6p4/hPgbqnPvgzTHtz
 KiUw==
X-Gm-Message-State: AOJu0YwVER+5a7jH3RkGNEoMxoselsWviKCgr11igpQfN3PUUckIlfa/
 MOIEreaf6X6sOYh/1oOnCuKKUx0o1ZYYOuVYy06BZaHOLks8XLdgIUnjoA+3ClMaTVrz6k4aLP2
 daIFyVtEdAmXX5iHyg17EE4+VtJyEy25QpA6ju4+8Bbvj1AsYHkKinf2ol96exeQIbQ==
X-Gm-Gg: ATEYQzx1enqSyAd7aBinpw7GLl5HntUT2y5FnZZM50gntqJJKMlG/9S0Ph+z2JNEf4I
 17fRcY9RhEjjYJlFg0HDZhthY+0B/ggJBeYztFVvXJWOF6Vsduz50dBWk+QNO+rqjEGXEwx6UlZ
 W93PP5V/b/g2mls8bIsYGz0vxdvv0KkV+u9Ukn9YdZ24jR9E29wr6v4/iIQA5ldyy0JKAsV7lqt
 SmQIfvyCNhMQo4uap9CS/sRAbxBFYPwZNnOihL8/XeAnyaXcg7pTyAKDvAFdcNOAi6c7U9aPMUq
 +voffbVq0VfsrUhyzllh2bPGbkHwijKqfEme8y5FLKVIEN2X5xmMcNnBj+nzPrPv1kmtj4vQsh/
 ZMmgG0jOzFU9KRBlUrpoiVt+Kry42ZT+xP5WjHKlDiCVqudYnmNQkijzlXr/v93HHn7ItPA==
X-Received: by 2002:a05:7300:3255:b0:2c5:50fe:c78f with SMTP id
 5a478bee46e88-2c93116ed58mr1985359eec.12.1775057268897; 
 Wed, 01 Apr 2026 08:27:48 -0700 (PDT)
X-Received: by 2002:a05:7300:3255:b0:2c5:50fe:c78f with SMTP id
 5a478bee46e88-2c93116ed58mr1985336eec.12.1775057268308; 
 Wed, 01 Apr 2026 08:27:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 03/37] target/hexagon: Fix badva reference, delete CAUSE
Date: Wed,  1 Apr 2026 08:26:23 -0700
Message-Id: <20260401152657.314902-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=L90QguT8 c=1 sm=1 tr=0 ts=69cd3b3a cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=YHbvUooXmMNqKe3LDhEA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BacLbvJzNqpjkJzMT_v7JTqea6fvlqUz
X-Proofpoint-GUID: BacLbvJzNqpjkJzMT_v7JTqea6fvlqUz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NSBTYWx0ZWRfX+9LbyrvB5wQa
 DxwFgqLwpyqqVuJOCKotVggUI6PLQBro1tJuq0YwUv/AoSSKAnhU3jeARQwx5gy1VtrLzoMnBp8
 TgjCkFviNyXGUwUX0LYPgs9tjugYlGAWiBzqd7CqlfwHwHsqCMORFnJdjuHdp8DkvgxP+7f8YK8
 yo47mNOndaeyYl4qPwCKkvMRI6N7auIhBkgmgCGem4+12p+RJPvzBZu812daH2f9WTRzv5Mcmud
 KuFdwxqjNuuzjf/YIOTHaCN1l98wuKkqP5NBqfQuJd9S/UNivfiFDSDSYqQTcl432tDm8m5VSci
 909hoHv5oZPDcn9fLyJ0JWrRoLcCGCwaZMyjHYFBYWhPFtMB/0SuxV7Ayq0GZbCyO2AzWR9cOxv
 e+ICQVqVUD2+mQFdMV4Eoa6scBAb9D26+JoAi/YqcYiuG42YfqwTAszFLxJGN9Ca5UvmYKtdHZD
 fD1RlFB4cIgVRWfXsJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010145
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgQkFEVkEgcmVnIGlzIHJl
ZmVycmVkIHRvIHdpdGggdGhlIHdyb25nIGlkZW50aWZpZXIuICBUaGUKQ0FVU0UgcmVnIGZpZWxk
IG9mIFNTUiBpcyBub3QgeWV0IG1vZGVsZWQsIHdlIHdpbGwgZHVtcAp0aGUgU1NSIGluIGEgc3Vi
c2VxdWVudCBjb21taXQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+ClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8IDExICsrKysrKysrKy0t
CiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
ZmZkMTRiYjQ2NzguLjRmNzJkNDc1OWNmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtMTE3LDYgKzExNywxNCBAQCBzdGF0aWMg
dm9pZCBwcmludF9yZWcoRklMRSAqZiwgQ1BVSGV4YWdvblN0YXRlICplbnYsIGludCByZWdudW0p
CiAgICAgICAgICAgICAgICAgIGhleGFnb25fcmVnbmFtZXNbcmVnbnVtXSwgdmFsdWUpOwogfQog
CisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIHByaW50X3Rfc3JlZyhGSUxF
ICpmLCBjb25zdCBDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50IHJlZ251bSkKK3sKKyAgICBxZW11
X2ZwcmludGYoZiwgIiAgJXMgPSAweCIgVEFSR0VUX0ZNVF9seCAiXG4iLAorICAgICAgICAgICAg
ICAgICBoZXhhZ29uX3NyZWduYW1lc1tyZWdudW1dLCBlbnYtPnRfc3JlZ1tyZWdudW1dKTsKK30K
KyNlbmRpZgorCiBzdGF0aWMgdm9pZCBwcmludF92cmVnKEZJTEUgKmYsIENQVUhleGFnb25TdGF0
ZSAqZW52LCBpbnQgcmVnbnVtLAogICAgICAgICAgICAgICAgICAgICAgICBib29sIHNraXBfaWZf
emVybykKIHsKQEAgLTIxNiw4ICsyMjQsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2R1bXAoQ1BV
SGV4YWdvblN0YXRlICplbnYsIEZJTEUgKmYsIGludCBmbGFncykKICAgICBxZW11X2ZwcmludGYo
ZiwgIiAgY3MwID0gMHgwMDAwMDAwMFxuIik7CiAgICAgcWVtdV9mcHJpbnRmKGYsICIgIGNzMSA9
IDB4MDAwMDAwMDBcbiIpOwogI2Vsc2UKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVHX0NB
VVNFKTsKLSAgICBwcmludF9yZWcoZiwgZW52LCBIRVhfUkVHX0JBRFZBKTsKKyAgICBwcmludF90
X3NyZWcoZiwgZW52LCBIRVhfU1JFR19CQURWQSk7CiAgICAgcHJpbnRfcmVnKGYsIGVudiwgSEVY
X1JFR19DUzApOwogICAgIHByaW50X3JlZyhmLCBlbnYsIEhFWF9SRUdfQ1MxKTsKICNlbmRpZgot
LSAKMi4zNC4xCgo=

