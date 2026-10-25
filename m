Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0E606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bzMrofsZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WzziAxZx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKos8-00014K-U1; Sat, 24 Oct 2026 23:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKorB-0008Rg-2M
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKor4-0001XW-LQ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:25:09 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16a9c4172770
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=; b=bzMrofsZiv4a+jb7
 M+H/nu/INmAhgZwvjtnd+Zdu/H0fAT9S9MNxWVtrZctH1d5aQ6S8WiRKj4YtEYMf
 iil2hSlUuu/VVP/2PwTC31vF+Ya2xIAB4WqS1Ig8KnRRNGvB2B28kBQG+TqlEaTu
 ni0UAQKaSMuVh95fSL5gycZi6iYYGMwReUsl3CLyFlHVVZ202ML/ylHehH+VW5IS
 DDNmNrlkhM4AcX8BmIClVh+c2HdYuqcmNjPyqu1wCr2B+jAGpkznD+ZXgdnAIfD5
 113HEsx+Ip99bcvdF0Aog91qUN7tLBxTKrVzmdmQ2mPGyDyfYo6w0HDVNMZOk4lo
 UEqSlg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgjcgtnbm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3662e7a9299so10048343eec.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898694; x=1793503494; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=;
 b=WzziAxZx9Ojgg+WgFbNHJFaB9nfdz7bNQMDFz6XA3axkcZCew97tCCgRh6+JQzPKDU
 cP5N7J7krNNcXk/X2k1+67vCyQpDMr4qXJuvSi+tjcO/+Jtr/WQUtE4XnkeyJ50d0Z+f
 nkomQ4nejt/wpupLs/C8WfScLjdInB2D3JUkEd8OdY3AaaAXxIPPrheNCmWZmKaxxXkp
 WpG2oB1K+ox6BqhM/H3IIXB+p7sH5u7U0fMI5AXrkK6aqdTPKTdefifB1lJlxe7SpJ4R
 hCKeRzCc6j8fZd6GTFyLwIQuXFx2hd9AUU66/n6312T9L9YWvVWqpsYEol1ufTczaYJZ
 TUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898694; x=1793503494;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ks8rHQOzRf/igFiyuGs2wT8gWuheYIrUdzvmMLVOIS4=;
 b=Y7bBfDjoxYs/icZkZkPw/z+2AEz7MK68h38WpBBwq60AF1sQl0VheRf7qnogMPrFRS
 05ASC62vowO/KGzaeq/Sp+Ue1fbNljGNLaAjhzhdcoriylIpVW1pdJjRaIwYckiK6UeS
 doGTfh7+DoXRyeN6UPXtyIV4//8ZU5Of7OSraDeK2tzr3qyp4T2Q9+qqEZRgq053mDgp
 kQ5/nRQR+QZogwpmusJemFqzD9MQmqykBeWi0vWIm+HlPtNcr5rLke6YT9NwSaznLvPK
 DFSkqNy6k5d2AjpU7c073NRCebiiYRNCZuzl7qmqwJLfJhf5a1Ma/UrpAjJVAFYH67YT
 1N5g==
X-Gm-Message-State: AFq9FYIMSFgEuczfboclIUSASXL1ddcqbwSZntxjS/w3ZKtS3tiQddUx
 a+tQGsxead/NtjQnZWNi2tcq9sDzn8Odg34Oid9bVKdqX9vOv6prOipIWE1wnDf/+sPWRq4XYUx
 CdRY+0hM0DafWea5bFaHZVC28W1fH6cestKE3M58QVvXZlvrUyJapOMeVrpAaMjlnvQ==
X-Gm-Gg: AYBFou1kf9YkOB+B4QPvN6NcWClft6DB5ZRRpVoE81egsxCwf2fMX6dZGhUQyqobqPY
 jttMM+QdarQqBKuOIHaNPKoGIs/fkJ3AZLL3+6bwv6JZE21WJUXkXpS70cTWiNjmJ7PuN2dcoWh
 gcSqDGAjJZ3Gg+kKh33GkH9Gs6DBXYhHY+P+F1jSzC8eFKfQB9UVmWgDngrYp9dvmK/qXxEp9dk
 ZOGxSJymUypg7mrptXCWrBfjL8Yhw7/OO0m87oVX29PjHaZ2tHtL1mEtEIdRVXSi4TTEIbZmIXo
 2T2JnBl/9ODm0N3X+HMgZBLxJNlMb5DILbfHnUBPPFObcsd5JjTnCNxQJcZhNejBusklEt7I6tP
 Ser5YwAmyTrJ1udcEs7Bl67i2v8G1gLQw0+feDuKtOF3c3dM=
X-Received: by 2002:a05:7022:380e:b0:196:d6e1:108b with SMTP id
 a92af1059eb24-1993499dc6fmr4649883c88.10.1792898694418; 
 Sat, 24 Oct 2026 20:24:54 -0700 (PDT)
X-Received: by 2002:a05:7022:380e:b0:196:d6e1:108b with SMTP id
 a92af1059eb24-1993499dc6fmr4649848c88.10.1792898693851; 
 Sat, 24 Oct 2026 20:24:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 34/40] hw/intc: ciad should forward its mask to l2vic
Date: Sat, 24 Oct 2026 20:23:40 -0700
Message-Id: <20261025032346.2917451-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX5s1BxIoxo3AP
 9RW4V+Mn4TyQY/Aj4eb1IfcToaL+BUZl2eVDwqEK9f8uE8+vFbIaAOzHlJRsLhAEG9L0HDws/G4
 IoOgouM8HPh/AoYTrY0eW0gJE0V+okA=
X-Proofpoint-GUID: eGtOsDNDOjDod3Rp9dpjvJZcJ7igq8AA
X-Authority-Analysis: v=2.4 cv=JvhkP84C c=1 sm=1 tr=0 ts=6add7687 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=zi4VUfZ7aQnuQJZsh1MA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX/+tmIKbkDh3y
 FqQivDk/YBRdMtM4taRHvbNpq/lJdiU/1NU/o0Ttf/Gt6M/9HPbc5QRDCceYDIdabHfLl7TzL9Y
 t9PGcCkWwDClYXmDbzyr/04jqhJ8f2LKFhENXPDHXE4bBm536I/UPIphVccqfTKSkyLlI6DfLQs
 thXVPUd2m4I7bERHOE0FlRzTUf6Y8bzgxvUTg03OpsB1BNQ4JGivjinEIxj6vlwWW82Ll7VJyeT
 iEqtXRHsXLEGiiKOQ8BACv2yprleHiMtcMpKjIOoBqU3SE1IbQslGr9Dhept2T/+i5Ji1J8bTQW
 SURPc70GlP5LJhbGfriMPz8FZkcRzNqAUur+c2yTpOLY3yvx3F7UuLceV+Ixe4cf6CEZWHuL7u2
 nVZURHcKEXPdpfmzNzvycwnkAHr1SWSjCzhyrYw+5csKm4pKsyGPAulB+29ryr1n6qFBvq/szS1
 D2JOTLiSKNls0+qF0pw==
X-Proofpoint-ORIG-GUID: eGtOsDNDOjDod3Rp9dpjvJZcJ7igq8AA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610250012
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Y2lhZCBjbGVhcmVkIHRoZSBsYXN0IGludGVycnVwdCB0aGUgTDJWSUMgZGVsaXZlcmVkIHJlZ2Fy
ZGxlc3Mgb2YgaXRzCm1hc2suICBTbyBhIGNpYWQgZm9yIGFueSBvdGhlciBpbnRlcnJ1cHQgd291
bGQgZ2V0IGFwcGxpZWQgaW5jb3JyZWN0bHkuCgpPbmx5IGNsZWFyIHRoZSBhY3RpdmUgaW50ZXJy
dXB0IHdoZW4gdGhlIGNpYWQgYWNrbm93bGVkZ2VzIHRoZSBDUFUKaW50ZXJydXB0IHRoYXQgaXRz
IFZJRCBncm91cCBpcyBkZWxpdmVyZWQgb24sIGFuZCBvbmx5IGlmIHRoYXQgaW50ZXJydXB0Cndh
cyB0YWtlbiBvciBzZXQgd2l0aCBzaWFkLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaW50Yy9o
ZXgtbDJ2aWMuaCB8IDE0ICsrKysrKysrKystLS0tCiBody9pbnRjL2hleC1sMnZpYy5jICAgICAg
ICAgfCAxMCArKysrKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgfCAxNCArKysr
KysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmggYi9pbmNsdWRl
L2h3L2ludGMvaGV4LWwydmljLmgKaW5kZXggZWRjMjc4MjY2Y2IuLmFlMDY3ZmU5NWViIDEwMDY0
NAotLS0gYS9pbmNsdWRlL2h3L2ludGMvaGV4LWwydmljLmgKKysrIGIvaW5jbHVkZS9ody9pbnRj
L2hleC1sMnZpYy5oCkBAIC0zMSw4ICszMSwxMyBAQCB0eXBlZGVmIHN0cnVjdCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzIHsKICAgICB2b2lkICgqdXBkYXRlX3ZpZCkoSGV4TDJWaWNJbnRlcmZhY2Ug
KmwydmljLCB1aW50MzJfdCBncm91cCwKICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IHZhbHVlKTsKIAotICAgIC8qIENsZWFyIGludGVycnVwdCB1c2luZyBDSUFEIGluc3RydWN0aW9u
ICovCi0gICAgdm9pZCAoKmNsZWFyX2ludGVycnVwdCkoSGV4TDJWaWNJbnRlcmZhY2UgKmwydmlj
KTsKKyAgICAvKgorICAgICAqIENsZWFyIGludGVycnVwdHMgdXNpbmcgdGhlIENJQUQgaW5zdHJ1
Y3Rpb24uCisgICAgICogQG1hc2sgdGhlIENQVSBpbnRlcnJ1cHRzIHRoYXQgdGhlIENJQUQgYWNr
bm93bGVkZ2VkLiAgVGhlIGludGVycnVwdCBpcworICAgICAqIG9ubHkgY2xlYXJlZCBpZiBAbWFz
ayBoYXMgdGhlIENQVSBpbnRlcnJ1cHQgdGhhdCBpdHMgVklEIGdyb3VwIGlzCisgICAgICogZGVs
aXZlcmVkIG9uLgorICAgICAqLworICAgIHZvaWQgKCpjbGVhcl9pbnRlcnJ1cHQpKEhleEwyVmlj
SW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgbWFzayk7CiB9IEhleEwyVmljSW50ZXJmYWNlQ2xh
c3M7CiAKIERFQ0xBUkVfT0JKX0NIRUNLRVJTKEhleEwyVmljSW50ZXJmYWNlLCBIZXhMMlZpY0lu
dGVyZmFjZUNsYXNzLApAQCAtNTIsMTAgKzU3LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBsMnZp
Y191cGRhdGVfdmlkKEhleEwyVmljSW50ZXJmYWNlICpsMnZpYywgdWludDMyX3QgZ3JvdXAsCiAg
ICAgay0+dXBkYXRlX3ZpZChsMnZpYywgZ3JvdXAsIHZhbHVlKTsKIH0KIAotc3RhdGljIGlubGlu
ZSB2b2lkIGwydmljX2NsZWFyX2ludGVycnVwdChIZXhMMlZpY0ludGVyZmFjZSAqbDJ2aWMpCitz
dGF0aWMgaW5saW5lIHZvaWQgbDJ2aWNfY2xlYXJfaW50ZXJydXB0KEhleEwyVmljSW50ZXJmYWNl
ICpsMnZpYywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMy
X3QgbWFzaykKIHsKICAgICBIZXhMMlZpY0ludGVyZmFjZUNsYXNzICprID0gSEVYX0wyVklDX0lO
VEVSRkFDRV9HRVRfQ0xBU1MobDJ2aWMpOwotICAgIGstPmNsZWFyX2ludGVycnVwdChsMnZpYyk7
CisgICAgay0+Y2xlYXJfaW50ZXJydXB0KGwydmljLCBtYXNrKTsKIH0KIAogI2VuZGlmIC8qIEhX
X0lOVENfSEVYX0wyVklDX0ggKi8KZGlmZiAtLWdpdCBhL2h3L2ludGMvaGV4LWwydmljLmMgYi9o
dy9pbnRjL2hleC1sMnZpYy5jCmluZGV4IDczNmYxYmUzYjFkLi5iNzNlY2I4MjFlNCAxMDA2NDQK
LS0tIGEvaHcvaW50Yy9oZXgtbDJ2aWMuYworKysgYi9ody9pbnRjL2hleC1sMnZpYy5jCkBAIC00
NDgsMTIgKzQ0OCwxNiBAQCBzdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfdXBkYXRlX3ZpZF9p
bXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKICAgICBsMnZpY191cGRhdGVfYWxsKHMpOwog
fQogCi1zdGF0aWMgdm9pZCBsMnZpY19pbnRlcmZhY2VfY2xlYXJfaW50ZXJydXB0X2ltcGwoSGV4
TDJWaWNJbnRlcmZhY2UgKmlmYWNlKQorc3RhdGljIHZvaWQgbDJ2aWNfaW50ZXJmYWNlX2NsZWFy
X2ludGVycnVwdF9pbXBsKEhleEwyVmljSW50ZXJmYWNlICppZmFjZSwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBtYXNrKQogewogICAg
IEhleEwyVklDU3RhdGUgKnMgPSBIRVhfTDJWSUMoaWZhY2UpOworICAgIGNvbnN0IHVpbnQzMl90
IHNpemUgPSBMMlZJQ19JTlRFUlJVUFRfTUFYOworICAgIGNvbnN0IHVpbnQzMl90IGFjdGl2ZV9p
cnEgPSBmaW5kX2ZpcnN0X2JpdDMyKHMtPmludF9zdGF0dXMsIHNpemUpOwogCi0gICAgaWYgKHMt
PnZpZCA8IEwyVklDX0lOVEVSUlVQVF9NQVgpIHsKLSAgICAgICAgY2xlYXJfYml0MzIocy0+dmlk
LCBzLT5pbnRfc3RhdHVzKTsKKyAgICAvKiBWSUQgZ3JvdXAgbiBpcyBkZWxpdmVyZWQgb24gQ1BV
IGludGVycnVwdCBuICsgMiAqLworICAgIGlmIChhY3RpdmVfaXJxICE9IHNpemUgJiYgKG1hc2sg
JiBCSVQoZ2V0X3ZpZChzLCBhY3RpdmVfaXJxKSArIDIpKSkgeworICAgICAgICBjbGVhcl9iaXQz
MihhY3RpdmVfaXJxLCBzLT5pbnRfc3RhdHVzKTsKICAgICB9CiAgICAgbDJ2aWNfdXBkYXRlX2Fs
bChzKTsKIH0KZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggNzY5ZjU2ZTI0MjIuLjgyYzBjNmExNWYxIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYwpAQCAtMTY4NiwyNiArMTY4NiwzMCBAQCB2b2lkIEhFTFBFUihyYWlzZV9zdGFj
a19vdmVyZmxvdykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNsb3QsCiB2b2lkIEhF
TFBFUihjaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKICAgICB1
aW50MzJfdCBpYWQ7CisgICAgdWludDMyX3Qgd2FzX3NldDsKICAgICBIZXhhZ29uQ1BVICpjcHU7
CiAKICAgICBCUUxfTE9DS19HVUFSRCgpOwogICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7CiAg
ICAgaWYgKGNwdS0+Y2ZnLmhleF9kZWYtPmhleF92ZXJzaW9uID49IEhFWF9WRVJfVjgxKSB7CiAg
ICAgICAgIGlhZCA9IGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhf
U1JFR19JQUQsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJl
YWRJZCkgJiB+bWFzazsKLSAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5nbG9i
YWxyZWdzLCBIRVhfU1JFR19JQUQsIGlhZCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbnYtPnRocmVhZElkKTsKKyAgICAgICAgd2FzX3NldCA9IGlhZCAmIG1hc2s7Cisg
ICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SUFELCBpYWQgJiB+bWFzaywKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50
aHJlYWRJZCk7CiAgICAgfSBlbHNlIHsKICAgICAgICAgdWludDMyX3QgaXBlbmRhZCA9CiAgICAg
ICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGNwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
SVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCk7CiAKLSAgICAgICAgZlNFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCwKLSAgICAgICAg
ICAgICAgICAgICBmR0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURfSUFEKSAmIH5tYXNrKTsKKyAg
ICAgICAgaWFkID0gZkdFVF9GSUVMRChpcGVuZGFkLCBJUEVOREFEX0lBRCk7CisgICAgICAgIHdh
c19zZXQgPSBpYWQgJiBtYXNrOworICAgICAgICBmU0VUX0ZJRUxEKGlwZW5kYWQsIElQRU5EQURf
SUFELCBpYWQgJiB+bWFzayk7CiAgICAgICAgIGhleGFnb25fZ2xvYmFscmVnX3dyaXRlKGNwdS0+
Z2xvYmFscmVncywgSEVYX1NSRUdfSVBFTkRBRCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaXBlbmRhZCwgZW52LT50aHJlYWRJZCk7CiAgICAgfQotICAgIGwydmljX2NsZWFyX2lu
dGVycnVwdChjcHUtPmwydmljKTsKKyAgICAvKiBPbmx5IGFuIGludGVycnVwdCB0aGF0IHdhcyB0
YWtlbiwgb3Igc2V0IHdpdGggc2lhZCwgY2FuIGJlIGNsZWFyZWQgKi8KKyAgICBsMnZpY19jbGVh
cl9pbnRlcnJ1cHQoY3B1LT5sMnZpYywgd2FzX3NldCk7CiAgICAgaGV4X2ludGVycnVwdF91cGRh
dGUoZW52KTsKIH0KIAotLSAKMi4zNC4xCgo=

