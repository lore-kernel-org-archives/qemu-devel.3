Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EA7C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnKlu-0002F6-8H; Fri, 24 Jul 2026 14:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlX-0002Cc-8c
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:37:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wnKlU-0000t4-1T
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 14:36:58 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OHBhac3684050
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=; b=FNJcEdprPuDzizQN
 WjnnUZfY9tOwok4GdSKgvvFB3rTvg2oXgegc8cNLnP5Ui12Z2wdLL6euZL70vVQJ
 dC0SJv1b9TsBGgopTnMRFYBpEU1yAUP/M4d2zslnSRXqucMkzSs9scTvpXJYYTbR
 wF8rCKJOUb69zJExBaGqtGOpCNcTK9Nx6sMw8p7EDPXhLsy8aI+qKKSR2MfTKsbx
 MarIKXR24nHrl+JKIxC3cdsf8bVonxZm2MKWfps0OAMVkajrvBQ5o5k5PkoJyVC1
 Cp7xtnGm8jAQwmUg6xUDWEJoO6AnBh0BBETbyMFgin5ZQe0XXM+u/QfKTR3fB/PX
 J3MxPA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmc7x09nn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:36:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so837853a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784918214; x=1785523014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=;
 b=VqA8yienpIq3Us2EUwgj/+1Km00BbBHKG3euy7NFzMJRo+htKQOVvfFbCXYxwJnzGK
 YG33I8SzDSfCOAw08TK3v1dD4QzuUGnTnW+2++9MBquRKzzn9/t0B4h0IP4SwsW+ba4D
 7IRBTsLR7jbFHnCHnkC/c46z+psrrzusMPLZV5m9uCrTebkVoqcNKEG2srir7MTG2ei7
 Mbnrx0s7e9ypdtEFQVx8Y5XyHJwAKp8fNw8tWWeeM6J7joDT+Kg/ViTGbVRSvITcqW8L
 imICREYkXU4AR1Me6cd9RAbg3OrJpaTMc/V7Cz/9QL0kfNnEjlqyCwM+yG0105op6onL
 D+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784918214; x=1785523014;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=;
 b=rwszGhqka2CcJFf3E3+1rHL4WAScVZXo2K6me0TcpsQL/1/BI3e0gGvnvehf5Fqede
 Xtjoy7XuDogFzwqd4W59RwlR+T6AYCSIW4FFpeu0PFXQDRhWCULR8nhFDQ0gPg6hl7BN
 eBvEzuvh0ZtQwGsYx91hf7kGLkUK0GI3qJRI9TYwk55zAXfeGLWG3spp0nt6ix1YGZyu
 uTSGmvitHAnOGShTt20VHlOaj+7qOhy8o7AdpjOV18tQ+jS2Y4GcFbX/OZ/ccKN3UPZl
 eKnrnk9vKeja2HYJ7m6emTg/KOsDp+OKeJvFHZQ6ioaw307XndLQXbGj4BjbwMCOAShA
 P55Q==
X-Gm-Message-State: AOJu0YxtBrrTdM122ieSLTugmSlZdjUkojL+TRwdkJ5GmyPYB6Nh05EI
 KMRWBXlBSiw1dbezKmzHrlwDrWFxD5AmsK38bske/DnE5ewvfIC8EYYlGOx+tdlZZHNOmftg+Kg
 dZVLimm03giuSSr/UjKDgeBN+tNF9dIEW1mnilthxzojlB1dTCzY5Yez5OPdhMmFLTA==
X-Gm-Gg: AR+sD12AKWaPUeCd9zxaBa2Ju62auCplxdg4XFHUWS3Wv7632vpTmmZ+sHTyYIAq6cf
 h5xI+TBF+11mGAcKev1/V/sXgnk2qjy7RKr6tGljK9rBWP8qe5kCTz8A40SeulVOgk8s1mtZz7H
 ZyjYL9RRVo1X5J2q0Bj/VPl0j6+bOHUOKfHu+KEukGaTucOffmKq8MZBsQ+crdMrhiCNLNbKpfg
 frcIh2HE7fJn8GZxKAOQIoRRbEHRoiSrTNKG1hw2pC9/M832CupQx6o2vbxbbv9ahonFg+pZOQx
 Xw24lmo8dPI7+WqfsJoUDQ3nrofdh8LI0r4gpXVV1xZMExI32cpw1BENOxRqpiKvnR/almC4NZF
 vh7+xeKwKTKgxjh3zNqs8C+JMcrfbZybU/oka2c9QDue7Jjwd
X-Received: by 2002:a17:90b:1c08:b0:380:ce69:2669 with SMTP id
 98e67ed59e1d1-38f1ebf8928mr1576230a91.9.1784918213360; 
 Fri, 24 Jul 2026 11:36:53 -0700 (PDT)
X-Received: by 2002:a17:90b:1c08:b0:380:ce69:2669 with SMTP id
 98e67ed59e1d1-38f1ebf8928mr1576206a91.9.1784918212900; 
 Fri, 24 Jul 2026 11:36:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e0f4a039asm49194c88.9.2026.07.24.11.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 11:36:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, matheus.bernardino@oss.qualcomm.com, 
 philmd@oss.qualcomm.com, Brian Cain <brian.cain@oss.qualcomm.com>,
 pierrick.bouvier@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 02/14] bitops.h: Add find_first_bit32()
Date: Fri, 24 Jul 2026 11:36:36 -0700
Message-Id: <20260724183648.190531-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
References: <20260724183648.190531-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: lZ55AT93P3zVHB19qbIYUtWUyhIP8VM0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX5PErEEUjpMDm
 i6UQ533F4AUXt3ZtH80o7CR7H1zd5eI02AmMIWwvvS0YTeId9Rjdw9M5DoYj5RcCKzxu2Vs3zdZ
 q3D3Wjb+opIno2F4rITi0nui0roZvhU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2NyBTYWx0ZWRfX7OvbCTOnCAoN
 rKVaxfR8MzIhCzyT6omsHqsrFfsThV6NppkYADWnlMggV0fgDAmc8RBd1/bRoKFEWcYEI53L19q
 4WbAUWF/gSCJ9OnTA/0BcwZrtc349inTI/oRZcMaYOw64ynz3sbnCurxdm4VohKPKfQbMzLPLX3
 i+/5Mc/LU82xi3y9rsAiTyZp+HVUo5S11I5FdAaLASj7xLt66i03zV+FjVI3WxE6f8G/UunYzKU
 y796oMDBYJTXNXAm82Ji3xW7lhjA8Y1u4fBjXoAwSggWff/5nEAOAe27gYzE+RiLWaBg2y+4xWo
 ZFNZZCw0DWTQFXQ0vzVns29obh0elJDAiwvw3TZJFCrlH/DDhtcqeIZd2PLy6rx7Uyk8AbvfwUB
 lKtWAArgn/t4XTzgIO3C/ZQakaTfI3tPyvtYo8JPjJawyqrylPwlovn9UQ0SawHEKhkHd2zwRKo
 P25nhnAvkx6Ma8JJJiA==
X-Proofpoint-ORIG-GUID: lZ55AT93P3zVHB19qbIYUtWUyhIP8VM0
X-Authority-Analysis: v=2.4 cv=bOUm5v+Z c=1 sm=1 tr=0 ts=6a63b0c6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=w2bVgGKsJa40EddZz84A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240167
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

c2V0X2JpdDMyKCkvdGVzdF9iaXQzMigpL2V0YyBhbHJlYWR5IGxldCBkZXZpY2VzIG9wZXJhdGUg
b24KZ3Vlc3QtdmlzaWJsZSB1aW50MzJfdCByZWdpc3RlciBhcnJheXMgd2l0aG91dCBkZXBlbmRp
bmcgb24gdGhlIGhvc3QncwondW5zaWduZWQgbG9uZycgc2l6ZS4gIEFkZCBmaW5kX2ZpcnN0X2Jp
dDMyKCkgc28gY2FsbGVycyBuZWVkIG5vdCBjYXN0CmEgdWludDMyX3QgYXJyYXkgdG8gJ3Vuc2ln
bmVkIGxvbmcgKicuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogaW5jbHVkZS9xZW11L2JpdG9wcy5oIHwgMzAgKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvYml0b3BzLmgg
Yi9pbmNsdWRlL3FlbXUvYml0b3BzLmgKaW5kZXggYzdiODM4YTYyODMuLmY3MzYzYTU0NzlmIDEw
MDY0NAotLS0gYS9pbmNsdWRlL3FlbXUvYml0b3BzLmgKKysrIGIvaW5jbHVkZS9xZW11L2JpdG9w
cy5oCkBAIC00MywxMCArNDMsOSBAQAogICogYmUgc29tZSBndWVzdC12aXNpYmxlIHJlZ2lzdGVy
IHZpZXcgb2YgdGhlIGJpdCBhcnJheS4KICAqCiAgKiBXZSBkbyBub3QgY3VycmVudGx5IGltcGxl
bWVudCB1aW50MzJfdCB2ZXJzaW9ucyBvZiBmaW5kX2xhc3RfYml0KCksCi0gKiBmaW5kX25leHRf
Yml0KCksIGZpbmRfbmV4dF96ZXJvX2JpdCgpLCBmaW5kX2ZpcnN0X2JpdCgpIG9yCi0gKiBmaW5k
X2ZpcnN0X3plcm9fYml0KCksIGJlY2F1c2Ugd2UgaGF2ZW4ndCB5ZXQgbmVlZGVkIHRoZW0uIElm
IHlvdQotICogbmVlZCB0aGVtIHlvdSBzaG91bGQgaW1wbGVtZW50IHRoZW0gc2ltaWxhcmx5IHRv
IHRoZSAndW5zaWduZWQgbG9uZycKLSAqIHZlcnNpb25zLgorICogZmluZF9uZXh0X2JpdCgpLCBm
aW5kX25leHRfemVyb19iaXQoKSBvciBmaW5kX2ZpcnN0X3plcm9fYml0KCksCisgKiBiZWNhdXNl
IHdlIGhhdmVuJ3QgeWV0IG5lZWRlZCB0aGVtLiBJZiB5b3UgbmVlZCB0aGVtIHlvdSBzaG91bGQK
KyAqIGltcGxlbWVudCB0aGVtIHNpbWlsYXJseSB0byB0aGUgJ3Vuc2lnbmVkIGxvbmcnIHZlcnNp
b25zLgogICoKICAqIFlvdSBjYW4gZGVjbGFyZSBhIGJpdG1hcCB0byBiZSB1c2VkIHdpdGggdGhl
c2UgZnVuY3Rpb25zIHZpYSB0aGUKICAqIERFQ0xBUkVfQklUTUFQIGFuZCBERUNMQVJFX0JJVE1B
UDMyIG1hY3JvcyBpbiBiaXRtYXAuaC4KQEAgLTM4Miw2ICszODEsMjkgQEAgc3RhdGljIGlubGlu
ZSBpbnQgdGVzdF9iaXQzMihsb25nIG5yLCBjb25zdCB1aW50MzJfdCAqYWRkcikKICAgICByZXR1
cm4gMVUgJiAoYWRkcltCSVQzMl9XT1JEKG5yKV0gPj4gKG5yICYgMzEpKTsKIH0KIAorLyoqCisg
KiBmaW5kX2ZpcnN0X2JpdDMyIC0gZmluZCB0aGUgZmlyc3Qgc2V0IGJpdCBpbiBhIG1lbW9yeSBy
ZWdpb24KKyAqIEBhZGRyOiBUaGUgYWRkcmVzcyB0byBzdGFydCB0aGUgc2VhcmNoIGF0CisgKiBA
c2l6ZTogVGhlIG1heGltdW0gc2l6ZSB0byBzZWFyY2gKKyAqCisgKiBSZXR1cm5zIHRoZSBiaXQg
bnVtYmVyIG9mIHRoZSBmaXJzdCBzZXQgYml0LAorICogb3IgQHNpemUgaWYgdGhlcmUgaXMgbm8g
c2V0IGJpdCBpbiB0aGUgYml0bWFwLgorICovCitzdGF0aWMgaW5saW5lIHVpbnQzMl90IGZpbmRf
Zmlyc3RfYml0MzIoY29uc3QgdWludDMyX3QgKmFkZHIsIHVpbnQzMl90IHNpemUpCit7CisgICAg
dWludDMyX3QgcmVzdWx0OworCisgICAgZm9yIChyZXN1bHQgPSAwOyByZXN1bHQgPCBzaXplOyBy
ZXN1bHQgKz0gMzIpIHsKKyAgICAgICAgdWludDMyX3QgdG1wID0gKmFkZHIrKzsKKyAgICAgICAg
aWYgKHRtcCkgeworICAgICAgICAgICAgcmVzdWx0ICs9IGN0ejMyKHRtcCk7CisgICAgICAgICAg
ICByZXR1cm4gcmVzdWx0IDwgc2l6ZSA/IHJlc3VsdCA6IHNpemU7CisgICAgICAgIH0KKyAgICB9
CisgICAgLyogTm90IGZvdW5kICovCisgICAgcmV0dXJuIHNpemU7Cit9CisKIC8qKgogICogRE9D
OiBNaXNjZWxsYW5lb3VzIGJpdCBvcGVyYXRpb25zIG9uIHNpbmdsZSB2YWx1ZXMKICAqCi0tIAoy
LjM0LjEKCg==

