Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3752CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7V8-0003BC-Nt; Mon, 12 Oct 2026 00:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UM-0001yy-9B
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UK-0001BX-P8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lIrq915984
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sxkjJNWHfWDZivxg4pBBOVMEi4v3UGqOMhrcFRnkXJs=; b=NjOUajsUe8dAz1/S
 wQVC53WLv9w1tD/h/g2DREzfCK4GL8LrmkJ7N3I124F6w50Fmy3UsAGkDlTedfgu
 xV1nRCxSMbm2F74YSUmkkQYHzpkEf1SpmZM8PiULpi0sh4EEi1TzzCsM0+ECBVKo
 jEbftV5F56fEQ/UD2QgipXKaeqLgiz4H6AVez0UpeaLfLCMNjUZ1RUl6Tl8rvJCv
 TlugdS5O6UOtMc1y5ccLn02KyHVCm378xmlreH9v3wtfquwU8xT2YPmp/jdOGwwC
 5C8yghYnr93QCKFvaq/K/TnyUlot2tL6bOYoWOOU2yhUffnPWSVSGRHbvBzdcKpX
 FWTVPg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk24nda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3592749a017so1145327eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778681; x=1792383481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sxkjJNWHfWDZivxg4pBBOVMEi4v3UGqOMhrcFRnkXJs=;
 b=c6uzXuY40Df+nmAsXld4VfxG0I10OwfNYnvOV32suqLYHQg0aAuSB+mm1etkzPCm4r
 LvQYqV6hfEbQIzNTIQFcF/S4iZULonxSIaUd87eHPyJ5mtTz37Wj49AySf5LRNxi7Eb9
 j+BKeL1hC1VlcIV61TXm6ZWI5yVAd5Llfx9RL2MXG2+k5fhZY3fvu/6w3KMhdgThAY57
 zp3brdkKdSQ8Z5228Tz1tfgUu9Rb9Jq3K7KTnqmBOR9nMAbUTlqnuhZFLlvtPn25aRxm
 DZXbTV3zun6ruZDRyxIb/cQUTllY+qiyjONO9TgmMEk8xXM9UwNRU6RvolgI+l14ovBt
 Ypsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778681; x=1792383481;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sxkjJNWHfWDZivxg4pBBOVMEi4v3UGqOMhrcFRnkXJs=;
 b=TwG6bSXer0BnVbnOwmeAxaGnwcvVUzwM5XEBZniCk4NnfaX5e07taH2GZPGuoFqitq
 aGtOLMTdqaxcP3JhMiCeFgX0BwfbVTxy/LhMvieUnt+959or8uO5d64Z1FNWTCuQqLqm
 b0W+Rd/MlvsfDpBDFrrRE2Ilr/bJdhf6jbR03EfH6ddGsJL7YpaYa3hOtRbm7tt3l85X
 /LpWN5ayVIAL1Pq6OWeo31rK/BC7XVL9LqOXihvKxO3YA7AYUNu07IdASD4giuASGV4n
 8HGth25S900KAgY7CvKwbtYv05Cd6jh6Qan7xSXjsXdqi0KC4AEVlhsuu5QOAZY3OOZf
 AA1A==
X-Gm-Message-State: AFq9FYLVBk/H4ep5OJVTTYAw1Hvw2aQKa+mjJWm9c7eblVgFfr6RIPmy
 MI6Nn1VGLQQ4g3hRla9JnUSVouhNMYEwh8deR7im3U7uF0eRClcW2tY4ewkO3b+JUj3xqEWNRoz
 uGw6YTm0dVSGwhn3VZr7Zil3lQMPVdoWRsshmA25+mA6uQiq0Wp8FVxpzc0ncfiK9Xg==
X-Gm-Gg: AYBFou3+URXwRQDMASjlbcaUCWBKIokfI1W8EhhHdSmPNt92nckcEcJxoT9g3eMEWsO
 ao3m3JoVii/CC5rGz0UCvD6/SOSWD9W6oHia/GeRwJJbYji4VRrKe6trIM7AnvGZAPPSNJ452je
 gVunVGwq4agUUwG8dJ0XuPCTcZyWx6+C5frl/AUuHDR86yyNjQU87LC1jcTHEdozx0akgyBSRPz
 OLduR8Ar0QLddC6Lrf6qjvm54Hgyz3CuDGvk7QpPe8Dqkfal18GONJgxNTCrJZe9PsXduMx0vTD
 ygzOvwUcdoBNJq30bRiqhQFl0DSVhpIZlcTt3EY+vJ6rTTngnHA0g+ICCCWeDXGV3YBxehdxI+U
 qiewK0km609xaGFwixMk6JZRht9hqKpi1GNcdJez5upHglw0=
X-Received: by 2002:a05:693c:87cd:20b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-3536c53930dmr13525400eec.13.1791778680602; 
 Sun, 11 Oct 2026 21:18:00 -0700 (PDT)
X-Received: by 2002:a05:693c:87cd:20b0:353:5d7a:cabe with SMTP id
 5a478bee46e88-3536c53930dmr13525367eec.13.1791778679981; 
 Sun, 11 Oct 2026 21:17:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 20/25] target/hexagon: clear LL/SC reservations at context
 boundaries
Date: Sun, 11 Oct 2026 21:17:17 -0700
Message-Id: <20261012041722.1159355-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: JDf7Qn-jGgHyr8qW1DSCkE9uMHnOB6AC
X-Proofpoint-GUID: JDf7Qn-jGgHyr8qW1DSCkE9uMHnOB6AC
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acc5f79 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=nIBb1lFIQW7svKiJGhEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX7eBt5B/K0QrZ
 kj1YzCgeiSKhTrHl4YgwLzVN90iuWmbnL0pbR3KaxvMi2SAcyxmeZzwlA90+QcS1qM1Ruk+sop6
 Eqg2oxiI4j7G93ASbmKsCoZodX5WB2Tu9gpZx0EK4QJhtfVoUHJXP+2BuAAwArop1jxUOHOWDcJ
 sV7HdKt0BuhlDtYAMSC41uj91LWwzRXiMuleY6BwSQChRiZfu3SAZkYLHh4Iw6CLiEhHasZCSlm
 SNCFMK6L+dP/cLYMLsIJGWw3J7CurgA5XejlXyAHSoRt6MKhzAXAf8+uSJlTxp/iskp9WsdIeSX
 MmsqFUcAgcyE70dc9qTgc5Pr46c5Q9HgNhqJ4kVHnxpfmuxuQ1phijyME8x4p2jwzvUkXHeuxyh
 V7NvuDUfwHBTsB9H/0HR1l0YmN7hzcxPO72/5lkRgRRDEkGI+XR3pGhuFJvXy4g8N2gxRgW4ZtB
 pzMPPAde2zULMHPKAcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX3v8bfDh1Gz38
 3x06vJl4LzpOd5RnLOKsLIXdX/KrK49t5Nwt+Z9oiFBENBFG4YrAQhSa/LSy90kUDC06/XqiPbH
 nsKLAKcz/DZvrcFS7jBmioTBSN+WM8k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

U2V0IGxsc2NfYWRkciB0byB+MCBkdXJpbmcgcmVzZXQgYW5kIHNvZnQgcmVzZXQsIGFuZCB3aGVu
ZXZlciBsaW51eC11c2VyCnJldHVybnMgdG8gZ3Vlc3QgY29kZSBmb3IgYSB0cmFwIG9yIGEgc2ln
bmFsLgoKUmVzZXQgcHJldmlvdXNseSBsZWZ0IGxsc2NfYWRkciB6ZXJvLWluaXRpYWxpemVkLCBz
byBhIHN0b3JlLWNvbmRpdGlvbmFsCmlzc3VlZCB3aXRob3V0IGEgbWF0Y2hpbmcgbG9hZC1sb2Nr
ZWQgY291bGQgbWF0Y2ggYSBndWVzdCBhZGRyZXNzIG9mCnplcm8uCgpSZXZpZXdlZC1ieTogTWFy
Y28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIv
aGV4YWdvbi9jcHVfbG9vcC5jIHwgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAg
ICB8IDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2NwdV9s
b29wLmMKaW5kZXggZTRlZjk3YTExODQuLmU2YmIzYjYyYTlmIDEwMDY0NAotLS0gYS9saW51eC11
c2VyL2hleGFnb24vY3B1X2xvb3AuYworKysgYi9saW51eC11c2VyL2hleGFnb24vY3B1X2xvb3Au
YwpAQCAtMzksNiArMzksMTAgQEAgdm9pZCBjcHVfbG9vcChDUFVIZXhhZ29uU3RhdGUgKmVudikK
ICAgICAgICAgY3B1X2V4ZWNfZW5kKGNzKTsKICAgICAgICAgcWVtdV9wcm9jZXNzX2NwdV9ldmVu
dHMoY3MpOwogCisgICAgICAgIGlmICh0cmFwbnIgIT0gRVhDUF9BVE9NSUMgJiYgdHJhcG5yICE9
IEVYQ1BfWUlFTEQpIHsKKyAgICAgICAgICAgIGVudi0+bGxzY19hZGRyID0gfjA7CisgICAgICAg
IH0KKwogICAgICAgICBzd2l0Y2ggKHRyYXBucikgewogICAgICAgICBjYXNlIEVYQ1BfSU5URVJS
VVBUOgogICAgICAgICAgICAgLyoganVzdCBpbmRpY2F0ZSB0aGF0IHNpZ25hbHMgc2hvdWxkIGJl
IGhhbmRsZWQgYXNhcCAqLwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwppbmRleCBhNzRlYWE0NWZjMi4uNWFlMjAyNmViMmQgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC00
MTEsNiArNDExLDcgQEAgdm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0KENQVUhleGFnb25TdGF0
ZSAqZW52KQogICAgIEhleGFnb25DUFUgKmNwdTsKIAogICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgZW52LT5sbHNjX2FkZHIgPSB+MDsKICAgICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdID0g
MDsKICAgICBoZXhhZ29uX3Nzcl9zZXRfY2F1c2UoZW52LCBIRVhfQ0FVU0VfUkVTRVQpOwogCkBA
IC00NDYsNiArNDQ3LDggQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfcmVzZXRfaG9sZChPYmpl
Y3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpCiAKICAgICBzZXRfZGVmYXVsdF9uYW5fbW9kZSgxLCAm
ZW52LT5odnhfZnBfc3RhdHVzKTsKICAgICBzZXRfZmxvYXRfZGVmYXVsdF9uYW5fcGF0dGVybigw
YjAxMTExMTExLCAmZW52LT5odnhfZnBfc3RhdHVzKTsKKworICAgIGVudi0+bGxzY19hZGRyID0g
fjA7CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBtZW1zZXQoZW52LT50X3NyZWcsIDAs
IHNpemVvZih1aW50MzJfdCkgKiBOVU1fU1JFR1MpOwogICAgIG1lbXNldChlbnYtPmdyZWcsIDAs
IHNpemVvZih1aW50MzJfdCkgKiBOVU1fR1JFR1MpOwotLSAKMi4zNC4xCgo=

