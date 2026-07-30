Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E94C54FCD
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpFZh-0005g8-0n; Wed, 29 Jul 2026 21:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZd-0005fO-MO
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wpFZc-0005a4-49
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 21:28:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U1Gkwb3699598
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=; b=iCuTaZGsPFleOTdj
 UjtHL8kS8yFX0gYYKRGyw2UKmKqtIPjxcWpmouSHkJWlAoKLbF12DYolzBOlf6fA
 H5AaJhgGUAP0oFb89OL6XeWUQSbusNrOboDVD+Pi3lIwit0vIr7QG8IgJg8lJVCu
 G1waYFUN5itIy6a4QrNTcJusXBi4sksDXY9zwa+H6zTYRw3qa9EhxgGWJ1fKNZXe
 9QgMzoKbKt8DGMATeHtUqJ5bBkE+Jy9bpap5azMZXTUhi1NsRpiRsPikh3Fh2ucW
 Jd5wOc3HI/6ujMMFe0ZUFxagT17ytpQyHW9z6iUNpK9FV+3nBx/uXNfDLViUiwbx
 pe2Z6w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqvte8169-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:28:34 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso1229755a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 18:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785374914; x=1785979714; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=;
 b=DXSVy+gOLzQCNowLSRwwCH+thMvgLAFhwDuZ9PbQwrE43qDS1cixmU1s2DTXabot/g
 o/FVNlhLu0NkuNV5fFr+qNcIfEE+lKSYVeh661LEOqE0m5wdjQgWtG2pli+ldFkB4PHg
 3uZcTPdLItDZ/SMtWSTyiy7v9OBupSBSVyhyMGuk61m7qyKojsvKqNJsU32bxnaGvRvF
 1vs92wHFfQiStKc86o/n5rTS+KXxfubHNtm5ja9/CyPDhiZPvEBwJ/pCzSLOtL8JT1up
 fGw51BZtQW3NJrGi87tDbzbCcf2XoV1Udic2qzEPLOhcNXQAm9LtfxXsPONztBFWVBDr
 uWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785374914; x=1785979714;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vivGOooEOVtBJmxvbSxjoSTPRhQMYKZC+TeOUjGdkH0=;
 b=m9kKTFj+fUhizUCkpOeWHF8j1sKo0EjSvAqZXya/E9i/hBvZsNUVN8fwmkkXSJSHzh
 9u6/1ac5ZcpDQ33MavmDhjDuSkMVjWU3TiOv3oMGSIiXT1pNeyFv/4r8Pi171HM0TfvT
 5qpjIKg+sjHQ6pTNB68BFh9nGQr/GYC7xcx8JnH0pgelUZNCGDBkNRjppUZzvyIPP6XY
 Py4G4Y87TB35HBtIz1BdaK4F6TkKLZcxUREPV92ChHA0dQFy4od0YfVrgcKUtBxh0BdW
 u0sjPnvEe+uSlvnjjJxto4hrZ0iWYrt6DJa5TKkVpmCIrbheQoRj6yx+VW61t9ca2485
 /kpA==
X-Gm-Message-State: AOJu0YxOY8Wy78zsIaTnT940zgtXXxfYe2eDQ5jfMPHLSwLAu6yMawT9
 CoweNxNQvwg4pWsT50ksyExkWGiHZsjrBwvUE7lIx8kTiI8Od1h1aAAsB7NyLApNhxl/kKSELHS
 SLk5DIXnX6/TRRRj6K5iCRTNnREEghmzHl4COKnmsFR2sKvYUEjQQ0FGPH8lR1Qrb9Q==
X-Gm-Gg: AR+sD13RZiIGqtURMLafuwOSlYCx14QkwepWmCL0sOTlSft8bK7g8nq0JlKm0Gg1DPe
 ZIxH3x2BO0Hf2LzrkAd4BI9n1AFNZ0MYJE7HOSn4pOwMJFWvHoGJHucpjtBo76+Q5C7QOzqN1/U
 0vfHcMVO4Cc5yqilxlLeUQtNb4hF0UQ2xYWdhic7rvc2YJiTTx6Z0NDOo00naTK9kx5JyERnR0m
 zvjsCbck8WIcsN++EzlByqzoFBPNDpoSWyYVVmRgk493jWFVoyqtIDIhUmsnRgSWvif4CCOc/A/
 VgfpskWDPtg/NEcJ858EFXMZDeHRR36FyS3aHUDw1Tbo46f02J2bvdnS13vm1gZoolUs7ZPXU6t
 yq5iwf2fz5uFbnz8YyKKJlcsIovirMV9Ba5y+9X93LzmfuphG
X-Received: by 2002:a05:6a21:608a:b0:3c3:a168:edc3 with SMTP id
 adf61e73a8af0-3c90085d261mr400141637.38.1785374914191; 
 Wed, 29 Jul 2026 18:28:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:608a:b0:3c3:a168:edc3 with SMTP id
 adf61e73a8af0-3c90085d261mr400119637.38.1785374913742; 
 Wed, 29 Jul 2026 18:28:33 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm13242162eec.27.2026.07.29.18.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 18:28:32 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com
Subject: [PATCH v4 06/18] bitops.h: Add find_first_bit32()
Date: Wed, 29 Jul 2026 18:28:11 -0700
Message-Id: <20260730012824.1135905-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: oQ22e5X9_biF3aIyctIvhdN1_xIytuxX
X-Proofpoint-ORIG-GUID: oQ22e5X9_biF3aIyctIvhdN1_xIytuxX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfX8WCVKDNfojWy
 cCQV7dsCDciGvPR5G9B1+3pVkmlMNUW36zwnv9/Ro0qkoOoTMx5T4HFNtLWZlG1UhjGlvb9x6SD
 xMUd3jTv5yfiGzaklJlAI7naRclh4Mo=
X-Authority-Analysis: v=2.4 cv=Tr3WQjXh c=1 sm=1 tr=0 ts=6a6aa8c2 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=w2bVgGKsJa40EddZz84A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwNyBTYWx0ZWRfX7c2qK9xQwqXl
 vEDjtPbEemXr5uNczPmjr7NP33zXsXoHa6IqZO/1xceuGg7g3ipyj4YPwVrI8Zz97iIfnlWJ36Q
 THSMoKAivZVAs/8o/9Gsdw0JAgefMD3qdg7a0jMQKSqzpbOWpJfH7FQ+F3NO4woTF46JJ9MaTrN
 rsspMZiWTE+9V/MF4nfc0FmbncQBeN2csivJVFUQhd/cb7l5tJt8mbPGdWnGVgkm9AXjs/4I05A
 RKueGvfljwEoadSptF4Gb3IyQ2Lxttv7cKbFcPmAdQ4lOkOnXsS9pz4v9DVES4YfQGB8IgVQNOm
 gVBfo5QoJJNQunjiej2nchlZaXolieuXyDpzsuR7/bk8zWJu56K6Z/JvhkEO1KQIPJIr2qpANIa
 e8cT2gInYbFmceyBPtYC8yEsDP93Pi4MVNix/t+gFsrEyMrSSTBWrLo7kXhXOHLO7S/UXc1UEGu
 6kYz5UVMq/RtDnxQHyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300007
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

