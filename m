Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE215C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2Tg-00072N-5C; Wed, 12 Aug 2026 02:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Te-000726-Kv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tc-0003lM-Ni
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C624Se2593403
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +u29WSyWl7DeLROVonyo7ApcUUoFSFPKVa/I0TtDg/s=; b=RwdfMiILeNLfZw9L
 H+sN0WLq/WldAFevmA1PiiV7M4/YpO42ppSaa//jCMpjyhnFIbbphgwntkt6o/Ip
 4Gb/PPxFfHRQAV2PE118qKRPMYBUwdIKwS9GqShbcC2zRKqUef1LkUuHr2oqivjt
 VtoeW2Heo9rH5++yJf2rDdX7c441RoMubV8IYYAQbTFc1OUXGXubm0/SLukLnkCU
 bvoDNU+ZaqOerDEngyP+d1ah497elchXN1Foj957zjLaCU5vYvjx/CDbkWHa+RLX
 rLxmkKnRHRZ1jawnR0HZYYuHiftM+xXPxF+Mc7D8TT5VnKlQRV8mionGxp04Q7aP
 AOXHKA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrje7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso8879725ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516210; x=1787121010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+u29WSyWl7DeLROVonyo7ApcUUoFSFPKVa/I0TtDg/s=;
 b=Dmumx+gWo1T+AvZx2hBeO10GtR6TgwWpPA1rQ5pdY49L5BnrQXqwY1Kr20U0N6o6UO
 NvrUYmCrus509wApCDhVKkAZrA9C22zWrt5Zwq/27NJBSl5hC1Rfud7GZpLZyu+wkxUj
 Y/J5EVHpQf30HfZffRubr1p1CkkluUlQVEfYb2BPqMTSc8LKDU7VQ+gIpKk8N3WZMnof
 k/5OAdbb3EX0Co6zC6wiN7Y0lunUK3ZixE0eP6skYFdCTaqw64P7t9/8+qD+zYaVL1t2
 b00mtXRB/Ouq1GqEXsx8fHO9g6jJWGr7XE+fbZSOOhKtzDes7tPymQfj3wagIOkjK49f
 SO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516210; x=1787121010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+u29WSyWl7DeLROVonyo7ApcUUoFSFPKVa/I0TtDg/s=;
 b=gsMwMY5AmlO/M3ysoXqrMbpPcVWj7bwJ420Wl4Kwr8syDj+/Xd/YNFBWVwewLPFUsb
 3ckxMkA1FkrHsveq5+j1Okxq4h2EOi/DY1DQhWNKFOqZdYWd6IAeOS8CM2umMFW8+dr+
 n2cMASVHxh/bDuMF028Tx1V7Ik81/fWQJBf2GcBwu7l/BiY9YQpmQxF9HTgxwJTdpkz6
 sMd0L1kNWEDXwI0euNisP5R+G7ob3jyTlbcZDJZ+/CpzaxrBDr29GCsg2ZJvqV7r/rKq
 MyjSOUhFYrbz11Y4CCs1rUhcQbvx83vScMe/1CTmiRjyCuiv9q73vpzmG18uTHA5oip4
 qsAw==
X-Gm-Message-State: AOJu0Yyf/XHesOPqUEXnpYyUpZg1XM5w19co3fwWm7tZ3SOijf473S52
 mWFapduCwHuqpSvKYUja1yp/7wT9J5V7NhgvC0+rPQogOZc/7q3Sq9/ntH5gPEnXph4PbpYpkJk
 xXA/pq1F6drXH+K6kMyiTDTSHiWCAg4NCsAiykvWe0Mh3hWgNSPCEaUMucBl0yCTodQ==
X-Gm-Gg: AR+sD12l/CuiP51v1D0MUiL4ivpuCg6bNQrjZyiiF6r/5PpvpyAFKfJNuMiUt7KBszS
 TZU83WtfVmbieAUHZRp6zUiEmkckOO9WFT/4KNbWN+mUuMDbGz9ZM7RMIvHQL9nO1Z6zxg8npCA
 K2zp2g2NziuBjZ07wGudfVrSNCHTe+a4L03XjstU8pLZbHNlsc8NqSlR6XJi/ya0HP4AZ/x+hld
 07nfW3HkFHilbrW8P9yNIwerEGBM8zjc33EqMmXfCgrQUN5s00ZD4V5Y8ucaHfSu9ibXGOEjiRK
 8jV0EUPSa64hm733jbjSmZPfEVfXtecjzgMwvOtNcqY0Il3mDRigtB4JlaP9AXbP29ulltCfiog
 EayC+X4tZgRu++IJGiqs10+PWB7MkVdrTGabR6/VuE7YYXfoB
X-Received: by 2002:a17:90b:1b0d:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-3930123788cmr2757009a91.5.1786516210327; 
 Tue, 11 Aug 2026 23:30:10 -0700 (PDT)
X-Received: by 2002:a17:90b:1b0d:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-3930123788cmr2756842a91.5.1786516209042; 
 Tue, 11 Aug 2026 23:30:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 06/41] bitops.h: Add find_first_bit32()
Date: Tue, 11 Aug 2026 23:28:57 -0700
Message-Id: <20260812062932.543840-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: wRScC45g_NcymRZhxnmgvJA9BbR56WSQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfXyg2iyxYUB9wn
 SD1q4i/bhmIMHgMxKnbnzE4WpfS676gO+CJXrTh8YvQ8dn7L6yocgFnxYz5ZWg4wDt0AejQrRMJ
 +KeUBnpoN6STq3XcQejVwH92TbZHXDA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX5qFQLGrfl8wl
 QTZeIBvwx+3W2lu1AumKKCfYJDH9rIxS0K0Sl+yITR9ZJ2Brgx8O4NOs+rMxosyWbwNyUgLmP7I
 pePj2CnVD7UkWknEP7RHVZFiJcLLDitFontulHrj7XSRajaTkvYUjhRjyGxr434EmnruZ0mGm0x
 eELeVT/nmOwlVP77mA3UlQY0JNyDs/h2DQqvgeqYBvdyiRmHP+1UynRHrhe9tlUW0P16Jqc8FzY
 4jryGlKZBRHQ6LCTVpR5k7qjkM5gjIk+4B29UGmL3OENr4gGqdl4e6sNFfLhhey1TZxpVC/mF7A
 X3OJmO+GUOLZ8EyluS1y0Bm8A4tBQCgBrPvHLfYTFF7Xqatzds7G1aTtPlhkxraOy1x2c/y29tZ
 oh8IWLkFNrUpDzOXi6QE7Yk3RfbR2b/5kfh8hcm2syB5LuNr9kHP7k68N8CYF6lzRq0Qswd73O/
 RPmC8SLGH4YtAS3PP8g==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c12f3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w2bVgGKsJa40EddZz84A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: wRScC45g_NcymRZhxnmgvJA9BbR56WSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120049
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
dmllckBvc3MucXVhbGNvbW0uY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjYwODA2MDQyNzIzLjM3ODUzNjktNy1icmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
PgotLS0KIGluY2x1ZGUvcWVtdS9iaXRvcHMuaCB8IDMwICsrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2JpdG9wcy5oIGIvaW5jbHVkZS9xZW11L2JpdG9w
cy5oCmluZGV4IGM3YjgzOGE2MjgzLi5mNzM2M2E1NDc5ZiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9x
ZW11L2JpdG9wcy5oCisrKyBiL2luY2x1ZGUvcWVtdS9iaXRvcHMuaApAQCAtNDMsMTAgKzQzLDkg
QEAKICAqIGJlIHNvbWUgZ3Vlc3QtdmlzaWJsZSByZWdpc3RlciB2aWV3IG9mIHRoZSBiaXQgYXJy
YXkuCiAgKgogICogV2UgZG8gbm90IGN1cnJlbnRseSBpbXBsZW1lbnQgdWludDMyX3QgdmVyc2lv
bnMgb2YgZmluZF9sYXN0X2JpdCgpLAotICogZmluZF9uZXh0X2JpdCgpLCBmaW5kX25leHRfemVy
b19iaXQoKSwgZmluZF9maXJzdF9iaXQoKSBvcgotICogZmluZF9maXJzdF96ZXJvX2JpdCgpLCBi
ZWNhdXNlIHdlIGhhdmVuJ3QgeWV0IG5lZWRlZCB0aGVtLiBJZiB5b3UKLSAqIG5lZWQgdGhlbSB5
b3Ugc2hvdWxkIGltcGxlbWVudCB0aGVtIHNpbWlsYXJseSB0byB0aGUgJ3Vuc2lnbmVkIGxvbmcn
Ci0gKiB2ZXJzaW9ucy4KKyAqIGZpbmRfbmV4dF9iaXQoKSwgZmluZF9uZXh0X3plcm9fYml0KCkg
b3IgZmluZF9maXJzdF96ZXJvX2JpdCgpLAorICogYmVjYXVzZSB3ZSBoYXZlbid0IHlldCBuZWVk
ZWQgdGhlbS4gSWYgeW91IG5lZWQgdGhlbSB5b3Ugc2hvdWxkCisgKiBpbXBsZW1lbnQgdGhlbSBz
aW1pbGFybHkgdG8gdGhlICd1bnNpZ25lZCBsb25nJyB2ZXJzaW9ucy4KICAqCiAgKiBZb3UgY2Fu
IGRlY2xhcmUgYSBiaXRtYXAgdG8gYmUgdXNlZCB3aXRoIHRoZXNlIGZ1bmN0aW9ucyB2aWEgdGhl
CiAgKiBERUNMQVJFX0JJVE1BUCBhbmQgREVDTEFSRV9CSVRNQVAzMiBtYWNyb3MgaW4gYml0bWFw
LmguCkBAIC0zODIsNiArMzgxLDI5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHRlc3RfYml0MzIobG9u
ZyBuciwgY29uc3QgdWludDMyX3QgKmFkZHIpCiAgICAgcmV0dXJuIDFVICYgKGFkZHJbQklUMzJf
V09SRChucildID4+IChuciAmIDMxKSk7CiB9CiAKKy8qKgorICogZmluZF9maXJzdF9iaXQzMiAt
IGZpbmQgdGhlIGZpcnN0IHNldCBiaXQgaW4gYSBtZW1vcnkgcmVnaW9uCisgKiBAYWRkcjogVGhl
IGFkZHJlc3MgdG8gc3RhcnQgdGhlIHNlYXJjaCBhdAorICogQHNpemU6IFRoZSBtYXhpbXVtIHNp
emUgdG8gc2VhcmNoCisgKgorICogUmV0dXJucyB0aGUgYml0IG51bWJlciBvZiB0aGUgZmlyc3Qg
c2V0IGJpdCwKKyAqIG9yIEBzaXplIGlmIHRoZXJlIGlzIG5vIHNldCBiaXQgaW4gdGhlIGJpdG1h
cC4KKyAqLworc3RhdGljIGlubGluZSB1aW50MzJfdCBmaW5kX2ZpcnN0X2JpdDMyKGNvbnN0IHVp
bnQzMl90ICphZGRyLCB1aW50MzJfdCBzaXplKQoreworICAgIHVpbnQzMl90IHJlc3VsdDsKKwor
ICAgIGZvciAocmVzdWx0ID0gMDsgcmVzdWx0IDwgc2l6ZTsgcmVzdWx0ICs9IDMyKSB7CisgICAg
ICAgIHVpbnQzMl90IHRtcCA9ICphZGRyKys7CisgICAgICAgIGlmICh0bXApIHsKKyAgICAgICAg
ICAgIHJlc3VsdCArPSBjdHozMih0bXApOworICAgICAgICAgICAgcmV0dXJuIHJlc3VsdCA8IHNp
emUgPyByZXN1bHQgOiBzaXplOworICAgICAgICB9CisgICAgfQorICAgIC8qIE5vdCBmb3VuZCAq
LworICAgIHJldHVybiBzaXplOworfQorCiAvKioKICAqIERPQzogTWlzY2VsbGFuZW91cyBiaXQg
b3BlcmF0aW9ucyBvbiBzaW5nbGUgdmFsdWVzCiAgKgotLSAKMi4zNC4xCgo=

