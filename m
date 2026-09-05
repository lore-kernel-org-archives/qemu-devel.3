Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80781C624D6
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqg-0002zH-St; Sat, 05 Sep 2026 14:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqf-0002yg-If
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uqd-0001jJ-1O
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:41 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbxLH1775634
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nxAGqIsONXx9B1ECT/Gsix3Fk+8qK64hV/IJK5ICtkc=; b=fzv82z2KXXZzIiRf
 rTj6Mt0nApEI+NHuVIR1/ZY8e1x3PhCVzCy0AuTaJnV8llO8AmKphXD5vh5sQTAC
 YGtyCJkwiyu5bHyIcg1iR29CZQxGdnsHAZ+qr8YyCXQsPenrV7Zg7Zqk4Xs5dbZx
 RaSpanDMstkum4rez8GQ5EEGy1Vy8G4Df/LgUYaNHo5O7oPgumT2nLkkpdzJOKDq
 bHDOQncp2z/g9WuoqhAhTiMsuvtDvt9jkxaNAbqpoVhBv30AU1upbukjfnUYPIm0
 wWr0Jn/zCsrWFp3GNSUBUYnXtAEHXQN4c7BGw7DQ+SjuDC+8Sk5BgWWIHg9Qfq5J
 Syb8Ew==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggc8j9u4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:10:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so2633769a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631837; x=1789236637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nxAGqIsONXx9B1ECT/Gsix3Fk+8qK64hV/IJK5ICtkc=;
 b=WtEWX1sJTHKrRhSBxSah7MpyNsYL2MbW2+Tfq4l+NE//KQ/D2OK1DylZAjB+ZGNmOV
 zN1bf7nJzV4KNXFNSTNOxg8rHfIZ0kjJiRQ0xWvnBcxYP9KxFjzJ1CygLjxJ0R4f2cWZ
 hmn5PvcBVikdU4MHgrNutoBYKaOWpkU3TMMApFXJQQqaE3WHP7faEoqVGsSm/QTWKbr4
 SO1d+q2NmqLAz3xXn8htEwPPNDQhF8G2Sj8Dgw8i4nzprBVLub9rU2XMmPPJn1TD5OCf
 ziEYwUs8gE/N+uWSVVCwKp4vvRLEpybafEzcpgrfrFHhFzQRsBmPafTxVccaarxlO/OW
 RggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631837; x=1789236637;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nxAGqIsONXx9B1ECT/Gsix3Fk+8qK64hV/IJK5ICtkc=;
 b=OOg7KhfzUK1ufS//oWQ3Ajfg1FsllZ+r8UWkSeVW6iMO+kNgk6g9A1slJd36v9U52n
 4f6zJpmd7hXeaisDY+eFwOUBj3nspduwOx+av6WFYtnb4/tRtXPnQwON6mpc+ypJqtfT
 ZsNqRnWmgO7HTznfty61QStX4x13av4XitUOPBxE8wiWaqLzB0PiC68Kb6keRFSZXj1P
 bYsCwWiiF2iqTVd2i15aQRPNNH4fhb7j4/zWvC9jwh/iB259z+vtN7iDSpDUswwXKz/6
 7GHSdDQabcA44nE+XB+9ARliTYwTsWeW1YOH3FkJab/c5rB6dc+0ME1WL3YK4/EueISu
 eiIA==
X-Gm-Message-State: AFuF++nK6p4R70SrRxtJpOIbMY4cmBtLrqXHs8ffO2dLtQ7cT753FtAj
 AeWG7SXCdCgs19tMX0BQAW1JhhCRpz1LDMFVHFmVj2SAmVntbIrqgI5u0ZKAj/w6RFL/CL9rLgr
 CfVDGarvZWkRGUcPRHHAjNiTL9Ktqx79sAJx1sFeUwYcmwAb3YN+TRRfR96X8Ed0v3A==
X-Gm-Gg: AYBFou3vXfu2bQgJ7+m/5ja3BsNy6IHKliSW79ZwBlbrQBnkRXA6yTpsTWDxw5Dnoi3
 Ovxdgh5uw4qt/YFqrczQ72XaQaUHe9FQnV1hHqlODmalkSSb4RJAH81i2eE7EKinovHook7toxK
 jOWeTGkrib2h8ObcfyyprBjjSold1HoglyzZP1u7H42PSPc+HM4C4OEXELYV9pNBloaIpAzWUDX
 ROjIhiFlNZZGzHQOoO2n0dwiaqhkEYQNKjo6uX/RcyeYSxW64A2O/HNJnBBQiRvQhfjtn0NVzoC
 C8DSMB0rYx/1fNTW38cHH1X6A6CjWRxP5NeWPnEOFT15LzubcmYZJdPGtKF3uIZP/k6CRQ3SkWW
 gUf7vX0CpaQcE6yP9WkhgYvN0sWJ2EsBgoR4yiAmX2LIqVIaX
X-Received: by 2002:a17:90b:538b:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-39b261d5148mr19955431a91.13.1788631837080; 
 Sat, 05 Sep 2026 11:10:37 -0700 (PDT)
X-Received: by 2002:a17:90b:538b:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-39b261d5148mr19955388a91.13.1788631836637; 
 Sat, 05 Sep 2026 11:10:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:10:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 17/17] tests/tcg/hexagon: add decbin MPS test case
Date: Sat,  5 Sep 2026 11:09:49 -0700
Message-Id: <20260905180949.1852673-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: RIr7keQuJ64GDPQawZLX44e_tO9Dy_5G
X-Proofpoint-ORIG-GUID: RIr7keQuJ64GDPQawZLX44e_tO9Dy_5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfXwerBpNbCqQud
 i/ZCws0qQLGo+fa1jysKpz+8XFGQcyf8TQ+dbuVRZhWyGWMEyYnrJz8lVrdgSVln90h1gokAZ/6
 fcnCWfO5zQ6Copu6vfc+LSGhRa4i5tZ2eZCfxJ6RdECgt7Yyu+ST3hK6pgARwj0q6fkjASUvAai
 WDHgniStm5CwogjeaPpaXsB7gaMGH0fLHmiFuHVQth9V3t77CwfqOKq61okjdA6TJvxsDyIJrCb
 e/EYprV59ac3WCQeQdsO3efdVwaG4UyalFuci0QuxnqYV7LVLYNgr6fllQ1xfQkadddFn1w2u3Z
 PCrCETgBewYmMHCoaF46AbgYGVVjqLSrlsMZv/po4w9RlLv2kniQRv7oPRdUbuB+4lPyw3v1Dj3
 6Gi7zM3eCtUaS/FD27hkl2SW3f31YFtdnEdkAFQ/8HMINKlsZbAbjm+MYPEmm3FgFKtTiF7LYsV
 7Q1pWzAwIqsrjOQw8QQ==
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a9c5b1d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QfmX1zfwqVA98Td9WrcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX+SH/M30V7McW
 snp6HjSPkDtzYFTfHF6AInHzXAimXlp0d+PwylCighfbH4taP3a4LxAcXyQnJNzpBeO6RXlF7G3
 mMVBznnd88eNeQXpaCQJOv4xhjT9Q+4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050201
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

QWRkIGEgZGVjYmluIHRlc3QgdmVjdG9yIGV4ZXJjaXNpbmcgdGhlIE1QUyBjYXNlCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVz
dHMvdGNnL2hleGFnb24vbWlzYy5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMgYi90ZXN0
cy90Y2cvaGV4YWdvbi9taXNjLmMKaW5kZXggYWJiMzRhYjZhNjUuLjA4ODQ1MjAxYjU5IDEwMDY0
NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9taXNjLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24v
bWlzYy5jCkBAIC01OTksNiArNTk5LDE1IEBAIGludCBtYWluKCkKICAgICByZXM2NCA9IGRlY2Jp
bigweGZMTCwgMHgxYkxMLCAmcHJlZCk7CiAgICAgY2hlY2s2NChyZXM2NCwgMHg3ODAwMDEwMExM
KTsKICAgICBjaGVjazMyKHByZWQsIHRydWUpOworCisgICAgLyoKKyAgICAgKiBUZXN0IHRoZSBN
UFMgKG1vc3QtcHJvYmFibGUgc3ltYm9sKSBjYXNlIGluIGRlY2Jpbi4KKyAgICAgKiBSc3M6IHdv
cmQwPXJhbmdlPTB4RkY4MDAwMDAsIHdvcmQxPW9mZnNldD0weDAwMDAwMDAwCisgICAgICogUnR0
OiB3b3JkMD1iaXRwb3M9MCwgd29yZDE9c3RhdGU9MHx2YWxNUFM9MShiaXQ4KQorICAgICAqLwor
ICAgIHJlczY0ID0gZGVjYmluKDB4MDAwMDAwMDBGRjgwMDAwMExMLCAweDAwMDAwMTAwMDAwMDAw
MDBMTCwgJnByZWQpOworICAgIGNoZWNrNjQocmVzNjQsIDB4MDAwMDAwMDA4NzgwMDEwMUxMKTsK
KyAgICBjaGVjazMyKHByZWQsIHRydWUpOwogI2Vsc2UKICAgICBwdXRzKCJTa2lwcGluZyBjYWJh
YyB0ZXN0cyIpOwogI2VuZGlmCi0tIAoyLjM0LjEKCg==

