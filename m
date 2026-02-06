Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF10EEE6B4A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQiw-0001AT-Fw; Fri, 06 Feb 2026 13:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voQim-000186-OE
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:38:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1voQik-0008Cy-QW
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:38:24 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 616GxA6j694761
 for <qemu-devel@nongnu.org>; Fri, 6 Feb 2026 18:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z1WeDq8iLYhbAxqSSPx1kZ21cBW0C5MfaYx4W488Dm8=; b=RXsa9jRGZEQWqKQ2
 PlAtPp3sa/3TrggOgJvIOCHv2fINDVfPswAblKax4TcTII1sL+6Cc0lflIbhIqg3
 MtjQqKEu90QPAly/9arTOaz7P55QYMz+LWj26XDEYZB17MpjrvI4nO5+53Wg7Uq/
 oEANDI5kiv5G4gMppKe9YdQu3Y2Xw+2T9YO6LjmpmOE3xcTv7cKfdzL1asf5tcuD
 nFdOy7Eno4xOCdTy7fZQ/BALDnVRV1eVZP4pp48ZEwu0Ms0IQ8yXUnTRntekTmAg
 9hoPRturQsPpsbCU6mh2NB7K7hEW7i2RpHa6WaG73djDLSXTov4C9cn0eidDjNiz
 RdV3TQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c53qvbjbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 18:38:19 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b71c5826fbso2512934eec.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770403099; x=1771007899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1WeDq8iLYhbAxqSSPx1kZ21cBW0C5MfaYx4W488Dm8=;
 b=KY12B6PDWm8oxz0ZL2yvR4aNV4ysMDOGm6Oq57YrxbUtKgIb6ZCYaJbs08JraKP02r
 zD92Jz0a+K6nf5naKqrlLUpYPBiH4zI2ztf5iRIXiUB6eJINChTGr9PA26ET+n6+RFeR
 HZxXRLt2HK5xGb8bHdmuQckUQ+J/JcdJpOgMer/kVCr8EBoEV8PS0AkXxbDakN/MyFO/
 ih9R50BYa+Enb6OXO+Q7Hc62gc0DWAKbHq9KpahoDZRKoOn6x7xsYZFDEBW0AP4u/u3e
 OUS9ryP4eTbFtNnOyqrIvpSEcw9s+Qtn/H0tJ2AUpbho5clml9FwTOo2ennqW0e0uC0U
 06Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770403099; x=1771007899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z1WeDq8iLYhbAxqSSPx1kZ21cBW0C5MfaYx4W488Dm8=;
 b=mYrRNaxRlcsMVTnuqAdXrQP0mx505pe/U+1+Eh1v/frQDYzA29/uMAsg/p+CzIoScL
 Nb+118dBCR/fbFvu2mKkGjBK1+p9p+JP79fBtCBraRU+ZqgTF+PqH/nGItGfIx692nbD
 Ps4rDy1pJI4gtLuiYFKJVVOCTqZ8TAbtLz8qe7WD+gZFo10vxEbjC68yqGjRx166x+pm
 uFFn+0IPO63Cplu2oraUPfwIx00c4EJBu8VinmRFsmctdSnQapMBg/Z2wNtT5QReHdLd
 AEHs5/raS6sKjIAwe6nT4LTtRHQl8XqPSa+EWUtjKwHEXX0KSHM5wDXnVQ98lhZ37RnN
 aQ4w==
X-Gm-Message-State: AOJu0YzlN/NAq+/KjUPFHUNueA0grhxR91lh80T1HbyUa2CTRm1guzbF
 rdoOpAaUStxdKAjwnIeFSVdwtjlja6ny4kd3luUx1FBlQY7wF9vFovIESTNcchIHrOSiQU3DuwK
 301v0MWJ2lvOeDj03IXTNIFfm9GLu2mlZ50Ibgg/IkvlsBuwTd1VJhDk+cal3wpzspg==
X-Gm-Gg: AZuq6aIKZqufCjuKoIMHMSu2gSi6GqS0IYz4ebrTz2iS1uvbNbSfuljFL4rijd8fUet
 R9M+Qk//QPYiZfjRxnzc59E9awlUMctDOKJK2GwXELhxSG4PDf+Cvo6eYM6c8zGF0GdqnMKfvL+
 s2XulJ/pwgjncxBJqG408pNASda0UX9VoUJP7KFWPEcse75Wz/gwIA2ij+knx013G27K6i3Y8Ib
 DH262BfNv6aQCFqtKOcblgbJDW10r58tCIWffBqjmTqrAseuBh09TEcnmaCmyDmSmu1YjOkaZtt
 J1Ba8Rn3OFfrWJNnPuug1JdqE8mfX6xgJyqDISJeg71sOdd8YnLWJM47ENlJGeHD4nz1mHqWK9N
 9OI5rUlpLt3YC7dBkZBlUfmrr+CK5Ij1Wm84olCntEDv5+SzPr6qh0r7vcw==
X-Received: by 2002:a05:693c:3007:b0:2b8:30b8:58c0 with SMTP id
 5a478bee46e88-2b8563d810cmr1782344eec.6.1770403098764; 
 Fri, 06 Feb 2026 10:38:18 -0800 (PST)
X-Received: by 2002:a05:693c:3007:b0:2b8:30b8:58c0 with SMTP id
 5a478bee46e88-2b8563d810cmr1782325eec.6.1770403098178; 
 Fri, 06 Feb 2026 10:38:18 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b855c3c846sm2270605eec.16.2026.02.06.10.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:38:17 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com, alex@alexrp.com
Subject: [PATCH 2/3] target/hexagon: Reject duplex encodings with duplicate
 dest registers
Date: Fri,  6 Feb 2026 10:38:12 -0800
Message-Id: <20260206183813.2573541-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
References: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=TsPrRTXh c=1 sm=1 tr=0 ts=6986351c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=ceJ5jWYMHQCwmun8QzEA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: kjI-jDiziXXwngjzJObDydtBAvMtJH9e
X-Proofpoint-GUID: kjI-jDiziXXwngjzJObDydtBAvMtJH9e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEzNyBTYWx0ZWRfX3xTdz+Qacqpd
 UfZ/Kf+OKtZuwymT9dmdyuoyDmCQJRoRVyDCRMqKCOP/zP3254Z64U+PBHxOvxPwr2XgLpk/zol
 zS48Avssf7MXjL8liBnnLwyVUlE7LbNr7erncAmEfYiBMcRrWmvoh53ey3fSDSAsaKrNA9oIfFK
 lH3U7ARXXX4DuLK/YYqAqNeoQcR3/9OrFvCY/7H5BP/OsvvD84pruE1biFw5RfDHUuLQxWmFrfQ
 /jVJtMcHIYj3eGp7OzaKZ6ogfMyRG39Kg5W9o8JhejDSASjTgJHn8Kv6mTlJPGqDimI8qJL3Hd0
 U9EetAR3WllFv8DQr3XNUEaunBEE1xxXT+mGHd080yhLzQJoq4VLplkUl9CkaJOg5gfFhoO3C6d
 R3Pm4OOk1jIVGRLnOtwDKm0coLYQXgruqFlq/uSbKrUbY+qrW8hs3Pu8LOgSQ9d8Oyfu+AcMPI1
 /LdY6K8rBjjH86AL+ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060137
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
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgfCAxMiArKysrKysrKysrKysKIHRlc3RzL3RjZy9o
ZXhhZ29uL2ludmFsaWQtZHVwcy5jICB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0
cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQgfCAgNiArKysrKysKIDMgZmlsZXMgY2hhbmdl
ZCwgNDEgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9oZXhhZ29u
L2ludmFsaWQtZHVwcy5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90
YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwppbmRleCA2OWJhMWVjOTZjLi45MDQ5OWZjMzIwIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYworKysgYi90YXJnZXQvaGV4YWdvbi9kZWNv
ZGUuYwpAQCAtNTAxLDEyICs1MDEsMjQgQEAgZGVjb2RlX2luc25zKERpc2FzQ29udGV4dCAqY3R4
LCBJbnNuICppbnNuLCB1aW50MzJfdCBlbmNvZGluZykKIAogICAgICAgICAvKiBUaGUgc2xvdDEg
c3ViaW5zbiBuZWVkcyB0byBiZSBpbiB0aGUgcGFja2V0IGZpcnN0ICovCiAgICAgICAgIGlmIChk
ZWNvZGVfc2xvdDFfc3ViaW5zbihjdHgsIHNsb3QxX3N1Ymluc24pKSB7CisgICAgICAgICAgICBJ
bnNuICpzbG90MV9pbnNuID0gaW5zbjsKICAgICAgICAgICAgIGluc24tPmdlbmVyYXRlID0gb3Bj
b2RlX2dlbnB0cltpbnNuLT5vcGNvZGVdOwogICAgICAgICAgICAgaW5zbi0+aWNsYXNzID0gaWNs
YXNzX2JpdHMoZW5jb2RpbmcpOwogICAgICAgICAgICAgY3R4LT5pbnNuID0gKytpbnNuOwogICAg
ICAgICAgICAgaWYgKGRlY29kZV9zbG90MF9zdWJpbnNuKGN0eCwgc2xvdDBfc3ViaW5zbikpIHsK
ICAgICAgICAgICAgICAgICBpbnNuLT5nZW5lcmF0ZSA9IG9wY29kZV9nZW5wdHJbaW5zbi0+b3Bj
b2RlXTsKICAgICAgICAgICAgICAgICBpbnNuLT5pY2xhc3MgPSBpY2xhc3NfYml0cyhlbmNvZGlu
Zyk7CisgICAgICAgICAgICAgICAgLyoKKyAgICAgICAgICAgICAgICAgKiBDaGVjayB0aGF0IHRo
ZSB0d28gc3ViLWluc3RydWN0aW9ucyBkb24ndCB3cml0ZSB0aGUgc2FtZQorICAgICAgICAgICAg
ICAgICAqIGRlc3RpbmF0aW9uIHJlZ2lzdGVyIChlLmcuLCBlbmNvZGluZyAweDAgZGVjb2RlcyBh
cyB0d28KKyAgICAgICAgICAgICAgICAgKiBsb2FkcyBib3RoIHdyaXRpbmcgUjAsIHdoaWNoIGlz
IGFuIGludmFsaWQgcGFja2V0KS4KKyAgICAgICAgICAgICAgICAgKi8KKyAgICAgICAgICAgICAg
ICBpZiAoaW5zbi0+ZGVzdF9pZHggPj0gMCAmJiBzbG90MV9pbnNuLT5kZXN0X2lkeCA+PSAwICYm
CisgICAgICAgICAgICAgICAgICAgIGluc24tPnJlZ25vW2luc24tPmRlc3RfaWR4XSA9PQorICAg
ICAgICAgICAgICAgICAgICAgICAgc2xvdDFfaW5zbi0+cmVnbm9bc2xvdDFfaW5zbi0+ZGVzdF9p
ZHhdKSB7CisgICAgICAgICAgICAgICAgICAgIGN0eC0+aW5zbiA9IC0taW5zbjsKKyAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIDA7CisgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAg
IHJldHVybiAyOwogICAgICAgICAgICAgfQogICAgICAgICAgICAgLyoKZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZHVwcy5jIGIvdGVzdHMvdGNnL2hleGFnb24vaW52YWxp
ZC1kdXBzLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMC4uY2IzN2VmNzA2
NgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ludmFsaWQtZHVwcy5jCkBA
IC0wLDAgKzEsMjMgQEAKKy8qCisgKiBUZXN0IHRoYXQgZHVwbGV4IGVuY29kaW5ncyB3aXRoIGR1
cGxpY2F0ZSBkZXN0aW5hdGlvbiByZWdpc3RlcnMgYXJlIHJlamVjdGVkLgorICoKKyAqIENvcHly
aWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFy
aWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyAqLwor
CisvKgorICogVGhlIGVuY29kaW5nIDB4MDAwMDAwMDAgZGVjb2RlcyBhcyBhIGR1cGxleCB3aXRo
IHBhcnNlIGJpdHMgWzE1OjE0XSA9IDBiMDA6CisgKiAgIHNsb3QxOiBTTDFfbG9hZHJpX2lvIFIw
ID0gbWVtdyhSMCsjMHgwKQorICogICBzbG90MDogU0wxX2xvYWRyaV9pbyBSMCA9IG1lbXcoUjAr
IzB4MCkKKyAqCisgKiBCb3RoIHN1Yi1pbnN0cnVjdGlvbnMgd3JpdGUgUjAsIHdoaWNoIGlzIGFu
IGludmFsaWQgcGFja2V0IChkdXBsaWNhdGUKKyAqIGRlc3RpbmF0aW9uIHJlZ2lzdGVyKS4gIFRo
aXMgc2hvdWxkIHJhaXNlIFNJR0lMTC4KKyAqLworCitpbnQgbWFpbigpCit7CisgICAgYXNtIHZv
bGF0aWxlKAorICAgICAgICAiLndvcmQgMHgwMDAwMDAwMFxuIgorICAgICAgICA6IDogOiAicjAi
LCAibWVtb3J5Iik7CisgICAgcmV0dXJuIDA7Cit9CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4
YWdvbi9NYWtlZmlsZS50YXJnZXQgYi90ZXN0cy90Y2cvaGV4YWdvbi9NYWtlZmlsZS50YXJnZXQK
aW5kZXggYjBlMjAxMzljMi4uNzE5OWUyOWEzMCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFn
b24vTWFrZWZpbGUudGFyZ2V0CisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL01ha2VmaWxlLnRhcmdl
dApAQCAtNTIsNiArNTIsNyBAQCBIRVhfVEVTVFMgKz0gaHZ4X21pc2MKIEhFWF9URVNUUyArPSBo
dnhfaGlzdG9ncmFtCiBIRVhfVEVTVFMgKz0gaW52YWxpZC1zbG90cwogSEVYX1RFU1RTICs9IGlu
dmFsaWQtZHVwbGV4CitIRVhfVEVTVFMgKz0gaW52YWxpZC1kdXBzCiBIRVhfVEVTVFMgKz0gdW5h
bGlnbmVkX3BjCiAKIHJ1bi1hbmQtY2hlY2stZXhjZXB0aW9uID0gJChjYWxsIHJ1bi10ZXN0LCQy
LCQzIDI+JDIuc3RkZXJyOyBcCkBAIC02OCw2ICs2OSwxMSBAQCBydW4taW52YWxpZC1kdXBsZXg6
IGludmFsaWQtZHVwbGV4CiAJCSQoUUVNVSkgJChRRU1VX09QVFMpICQ8IDsgdGVzdCAkJD8gLWVx
IDEzMiwgXAogCQlURVNULCBpbnZhbGlkLWR1cGxleCBvbiAkKFRBUkdFVF9OQU1FKSkKIAorcnVu
LWludmFsaWQtZHVwczogaW52YWxpZC1kdXBzCisJJChjYWxsIHF1aWV0LWNvbW1hbmQsIFwKKwkJ
JChRRU1VKSAkKFFFTVVfT1BUUykgJDwgOyB0ZXN0ICQkPyAtZXEgMTMyLCBcCisJCVRFU1QsIGlu
dmFsaWQtZHVwcyBvbiAkKFRBUkdFVF9OQU1FKSkKKwogSEVYX1RFU1RTICs9IHRlc3RfYWJzCiBI
RVhfVEVTVFMgKz0gdGVzdF9iaXRjbnQKIEhFWF9URVNUUyArPSB0ZXN0X2JpdHNwbGl0Ci0tIAoy
LjM0LjEKCg==

