Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A0EEE0AEF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 18:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vomi5-0001UI-45; Sat, 07 Feb 2026 13:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vomhz-0001Ta-RX
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:07:04 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vomhr-0005LM-HI
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 13:07:01 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 617DlDiI2132297
 for <qemu-devel@nongnu.org>; Sat, 7 Feb 2026 18:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u8zQ/PgN+M6EU0nqZmhx5VWC/id7HIJ3f/1jOvE3ams=; b=PaSGwpQ4lkZo5Mv0
 CS6A/CdhU6kGgrK9f6x5x5njCuGUybCEgVvsIIIZsbagWGs0ieXx062dLF5bIuVu
 WHOBYd2Tth1PvPdSn0SKwsYo1GsDDb7aUUo/UbB/XZ9h3cZFJaKbqDWW7A25/OpP
 aDAPllv0IHmlmlVVeHG8u0E6OfeheatHFGQRXSGtyY4fuvl3XzsDYl43IFRQIOEy
 ZBM16RtRbouaincS4QDxXT/ONQZfKoD1P3lBckxfLoiLXLiF3S2bpRR59O4WBfVs
 +HcBrHUiN3/TuHomwB9xLLioXC+Evkx273O7eKpX7qD9WeyKEGrMjlZh+8jL33CW
 m0aYHA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xj1938t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 18:06:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b708fa4093so9415532eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 10:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770487612; x=1771092412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8zQ/PgN+M6EU0nqZmhx5VWC/id7HIJ3f/1jOvE3ams=;
 b=SphfY5Lh4c3bUtM1P8s8mrSqMIyLqzVU3vmqG4rdh8IvzlUfRTIFfINLDiPWqMg+mH
 asVfE/oqJpcdBIt6gl0chMuLeFmsOHvAcY/RiwCirur+yjnMWN87VngH8szNloN9VLry
 j9DtKBx7MWYYXjDY9SmNc7WCf4hbObIv8SfewonsRngNfeDL/ZUbDUR/CVVDm+lLleS5
 VSdQ+KBugY5hdvsMkOmOUGPn42u9XT00KZgyJn4RvIRKL/V9tUjPUdVDN3pSGNXXzFt+
 uq8EpvxwLiIb8tLxnqHq5MQvdsgiTlyXB+uNLqdTKuBTqYCoCzgLQoLanh4SLYLYWRFI
 suqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770487612; x=1771092412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u8zQ/PgN+M6EU0nqZmhx5VWC/id7HIJ3f/1jOvE3ams=;
 b=M606dZXBVbOAdZEv88Ozff6A+1rENJf/b0lh2guY8H5wyf6N1+HFM36CkLCGYkUMR8
 sYl9TRQAYRWbYZZPU4yMaa/u7oci+nR2cH3e/UjTbyTuD8GfMddzVVfe/fxLYctPhL5F
 QnySoibrXPlNbLG97Pgoy3qQX1io+uq9IWeceA2/iepiqM988trH6azUTMlYyff73aja
 mh6S8sqXlvf0hIT7dHmoJi0UPYAtKsNBfuFf05lIcdVqdUe3TujIy2W8eGZ9t0Zhuu8J
 pWKlatLqriURIi7VbvXlrHfkbyZMiBEo94clzbd1tXIwJHY/zjLd8tneexeVn14JXuoL
 N+5Q==
X-Gm-Message-State: AOJu0YxB4T1qy/5XZaDkj8N1eBsbeit5QX7gfBY5O7UgnWZVblXmerOM
 y6FT52OML/XvnPnxYCAIq1kb5OQXnJU8tUM/qhsexb/ketGphmaKeNpO9iqEaOmoBy2gJkhMXSJ
 +Tp8LaBebHya9UGIktHC1XRnsck1/5BmrdAQLqxaRFyfenHyMeFoz5wTLvARrIw+SbA==
X-Gm-Gg: AZuq6aJWGJOkrLCPT7apsnPUiDMbBs1OK25dKvU9NjfmmjCtsTXynBsy2KCv10I8gZY
 cMV+dppruXs5FSMqG3Rcxp83pLv0W1X2cj4VSCHZds17X+JX5Z5Gls70Sx1N8otZueD5YZJFo/Q
 J8TJRcKZHVsYM81Y5B0QgL/GBLtO8VVYe9L/CH/bX2L9nMXhJCIlDPuZKn6cVZNCEQOTnYtLi72
 7U+2FvoUpdkMZOo6UMV7NwOczIJ0+YXp3+kHk0r81oUTv4DHwdoGDVNR1oLo/hnBywvJQ95bDbL
 FwWjoSSEhnqupB+6f/lCW5puXjf9sbeUZJhKUf8p+adnTzqtJN3rIpQWA2noqMGhC4aueu9i6w4
 /qmwGaVWqBQ8a0eu2WAKl6ZRNywk05cfbOA5uEwVxfTOBP8wd3GeVpgETOg==
X-Received: by 2002:a05:693c:2d8c:b0:2b7:1c58:dca6 with SMTP id
 5a478bee46e88-2b85646d9c4mr4349651eec.6.1770487611539; 
 Sat, 07 Feb 2026 10:06:51 -0800 (PST)
X-Received: by 2002:a05:693c:2d8c:b0:2b7:1c58:dca6 with SMTP id
 5a478bee46e88-2b85646d9c4mr4349638eec.6.1770487611030; 
 Sat, 07 Feb 2026 10:06:51 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855c63152sm4002328eec.25.2026.02.07.10.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 10:06:50 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 2/4] target/hexagon: Reject duplex encodings with duplicate
 dest registers
Date: Sat,  7 Feb 2026 10:06:30 -0800
Message-Id: <20260207180632.1042754-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
References: <20260207180632.1042754-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 1ShrdRGY-jCPL8tDYFihl2vi9ZxOhLgn
X-Proofpoint-ORIG-GUID: 1ShrdRGY-jCPL8tDYFihl2vi9ZxOhLgn
X-Authority-Analysis: v=2.4 cv=F/tat6hN c=1 sm=1 tr=0 ts=69877f3c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ceJ5jWYMHQCwmun8QzEA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDE0OSBTYWx0ZWRfXziov73BePCf8
 1C05VanEmJrrE9M+DVSDZj7qckorTPhVe+2YEWJmtIUKZULDKOaGkUzL7ELuUa83HCZzB5trzhN
 axPGt+wS6Kd9tEDSzkrrmgEozxzFl1LDUxDpKfKyystAnq8a/23lR675LRGlzbnS0lsioF71m4U
 +b4DfeittpBvfC7I0OPoBWe1llXvRy1Q0v2Yo8KPWX3sqViLI8tAjyx6q2R7YRLk7yWgZwwC9DO
 Ex70SFEI1PreMB6a7A1pz624l1SmEvKvwKuO9xC1aY6zQ7exgwxmBl+2fP0k3m6/Oq6CsvwSaU+
 ELluvO1pvHAX5dbyQHcq6qjTzVvVp1QfhbsR+amqwUJVkyXiwuCr73cV/kBF/4LFksOHD3kx0tU
 gwv8fi5RIYy4Wj1xACV62bFIg6r4iwBep3aOSMAUdmnveR9maH+B/5W9hczmg17JPUSbFkMowYZ
 BZTkaDmxeKpzZkBpkXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602070149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

QSBkdXBsZXggZW5jb2RpbmcgbGlrZSAweDAwMDAwMDAwIGRlY29kZXMgYXMgdHdvIGxvYWRzIHRo
YXQgYm90aCB3cml0ZSByMC4KCkFkZCBhIGNoZWNrIGluIGRlY29kZV9pbnNucygpIGFmdGVyIGJv
dGggc3ViLWluc3RydWN0aW9ucyBkZWNvZGUKc3VjY2Vzc2Z1bGx5IHRvIHZlcmlmeSB0aGV5IGRv
bid0IHdyaXRlIHRoZSBzYW1lIGRlc3RpbmF0aW9uIHJlZ2lzdGVyLgoKUmVzb2x2ZXM6IGh0dHBz
Oi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2lzc3Vlcy8yNjk2ClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4KLS0tCiB0YXJn
ZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgICAgfCAxMiArKysrKysrKysrKysKIHRlc3Rz
L3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKaW5kZXgg
NjliYTFlYzk2Yy4uOTA0OTlmYzMyMCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZGVjb2Rl
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKQEAgLTUwMSwxMiArNTAxLDI0IEBAIGRl
Y29kZV9pbnNucyhEaXNhc0NvbnRleHQgKmN0eCwgSW5zbiAqaW5zbiwgdWludDMyX3QgZW5jb2Rp
bmcpCiAKICAgICAgICAgLyogVGhlIHNsb3QxIHN1Ymluc24gbmVlZHMgdG8gYmUgaW4gdGhlIHBh
Y2tldCBmaXJzdCAqLwogICAgICAgICBpZiAoZGVjb2RlX3Nsb3QxX3N1Ymluc24oY3R4LCBzbG90
MV9zdWJpbnNuKSkgeworICAgICAgICAgICAgSW5zbiAqc2xvdDFfaW5zbiA9IGluc247CiAgICAg
ICAgICAgICBpbnNuLT5nZW5lcmF0ZSA9IG9wY29kZV9nZW5wdHJbaW5zbi0+b3Bjb2RlXTsKICAg
ICAgICAgICAgIGluc24tPmljbGFzcyA9IGljbGFzc19iaXRzKGVuY29kaW5nKTsKICAgICAgICAg
ICAgIGN0eC0+aW5zbiA9ICsraW5zbjsKICAgICAgICAgICAgIGlmIChkZWNvZGVfc2xvdDBfc3Vi
aW5zbihjdHgsIHNsb3QwX3N1Ymluc24pKSB7CiAgICAgICAgICAgICAgICAgaW5zbi0+Z2VuZXJh
dGUgPSBvcGNvZGVfZ2VucHRyW2luc24tPm9wY29kZV07CiAgICAgICAgICAgICAgICAgaW5zbi0+
aWNsYXNzID0gaWNsYXNzX2JpdHMoZW5jb2RpbmcpOworICAgICAgICAgICAgICAgIC8qCisgICAg
ICAgICAgICAgICAgICogQ2hlY2sgdGhhdCB0aGUgdHdvIHN1Yi1pbnN0cnVjdGlvbnMgZG9uJ3Qg
d3JpdGUgdGhlIHNhbWUKKyAgICAgICAgICAgICAgICAgKiBkZXN0aW5hdGlvbiByZWdpc3RlciAo
ZS5nLiwgZW5jb2RpbmcgMHgwIGRlY29kZXMgYXMgdHdvCisgICAgICAgICAgICAgICAgICogbG9h
ZHMgYm90aCB3cml0aW5nIFIwLCB3aGljaCBpcyBhbiBpbnZhbGlkIHBhY2tldCkuCisgICAgICAg
ICAgICAgICAgICovCisgICAgICAgICAgICAgICAgaWYgKGluc24tPmRlc3RfaWR4ID49IDAgJiYg
c2xvdDFfaW5zbi0+ZGVzdF9pZHggPj0gMCAmJgorICAgICAgICAgICAgICAgICAgICBpbnNuLT5y
ZWdub1tpbnNuLT5kZXN0X2lkeF0gPT0KKyAgICAgICAgICAgICAgICAgICAgICAgIHNsb3QxX2lu
c24tPnJlZ25vW3Nsb3QxX2luc24tPmRlc3RfaWR4XSkgeworICAgICAgICAgICAgICAgICAgICBj
dHgtPmluc24gPSAtLWluc247CisgICAgICAgICAgICAgICAgICAgIHJldHVybiAwOworICAgICAg
ICAgICAgICAgIH0KICAgICAgICAgICAgICAgICByZXR1cm4gMjsKICAgICAgICAgICAgIH0KICAg
ICAgICAgICAgIC8qCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29k
aW5nLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9pbnZhbGlkLWVuY29kaW5nLmMKaW5kZXggMDEwYTVl
Yjc0MS4uMWJiZDMxMmI2MSAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaW52YWxpZC1l
bmNvZGluZy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZW5jb2RpbmcuYwpAQCAt
NjUsNiArNjUsMzQgQEAgc3RhdGljIGludCB0ZXN0X2ludmFsaWRfZHVwbGV4KHZvaWQpCiAgICAg
cmV0dXJuIHNpZzsKIH0KIAorLyoKKyAqIER1cGxleCB3aXRoIGR1cGxpY2F0ZSBkZXN0aW5hdGlv
biByZWdpc3RlcnMgKGlzc3VlICMyNjk2KToKKyAqIFRoZSBlbmNvZGluZyAweDAwMDAwMDAwIGRl
Y29kZXMgYXMgYSBkdXBsZXggd2l0aCBwYXJzZSBiaXRzCisgKiBbMTU6MTRdID0gMGIwMDoKKyAq
ICAgc2xvdDE6IFNMMV9sb2FkcmlfaW8gUjAgPSBtZW13KFIwKyMweDApCisgKiAgIHNsb3QwOiBT
TDFfbG9hZHJpX2lvIFIwID0gbWVtdyhSMCsjMHgwKQorICoKKyAqIEJvdGggc3ViLWluc3RydWN0
aW9ucyB3cml0ZSBSMCwgd2hpY2ggaXMgYW4gaW52YWxpZCBwYWNrZXQgKGR1cGxpY2F0ZQorICog
ZGVzdGluYXRpb24gcmVnaXN0ZXIpLiAgVGhpcyBzaG91bGQgcmFpc2UgU0lHSUxMLgorICovCitz
dGF0aWMgaW50IHRlc3RfaW52YWxpZF9kdXBzKHZvaWQpCit7CisgICAgaW50IHNpZzsKKworICAg
IGFzbSB2b2xhdGlsZSgKKyAgICAgICAgInIwID0gIzBcbiIKKyAgICAgICAgInIxID0gIyMxZlxu
IgorICAgICAgICAibWVtdyglMSkgPSByMVxuIgorICAgICAgICAiLndvcmQgMHgwMDAwMDAwMFxu
IgorICAgICAgICAiMTpcbiIKKyAgICAgICAgIiUwID0gcjBcbiIKKyAgICAgICAgOiAiPXIiKHNp
ZykKKyAgICAgICAgOiAiciIoJnJlc3VtZV9wYykKKyAgICAgICAgOiAicjAiLCAicjEiLCAibWVt
b3J5Iik7CisKKyAgICByZXR1cm4gc2lnOworfQorCiBpbnQgbWFpbigpCiB7CiAgICAgc3RydWN0
IHNpZ2FjdGlvbiBhY3Q7CkBAIC03NSw2ICsxMDMsNyBAQCBpbnQgbWFpbigpCiAgICAgYXNzZXJ0
KHNpZ2FjdGlvbihTSUdJTEwsICZhY3QsIE5VTEwpID09IDApOwogCiAgICAgYXNzZXJ0KHRlc3Rf
aW52YWxpZF9kdXBsZXgoKSA9PSBTSUdJTEwpOworICAgIGFzc2VydCh0ZXN0X2ludmFsaWRfZHVw
cygpID09IFNJR0lMTCk7CiAKICAgICBwdXRzKCJQQVNTIik7CiAgICAgcmV0dXJuIEVYSVRfU1VD
Q0VTUzsKLS0gCjIuMzQuMQoK

