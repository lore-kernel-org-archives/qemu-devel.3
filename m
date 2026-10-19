Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2D606DA65
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=miu1ITH9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QYsPmoSA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpPF-00049L-IF; Mon, 19 Oct 2026 11:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIpPD-00048I-Kb
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:36:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIpPA-0004jr-SO
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 11:36:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFPRPC2816811
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7hq5nbvq3UYFK3vnPf8IbLUI7pGgpWATyJo/RjfnvO0=; b=miu1ITH9HzcTjxR4
 0CbavYDrwMNcE8T6b7h3hsOw+fPrHzDoABtKn8MOiVCz5zQgnaPLZlZoamgdL+kw
 b8JPXLrQz0TBEQWRkIy3rsHMhmR9hta60KGBntQgpY1OwdpGnWxtkVfRjnN9Gk5y
 +5taV8J9/i70Bpcpi2HXxvUX30QzLYmNlz6PTv97jGP3KPhQ9YsSOvRbYuwVfee6
 cmIjRnLzzjhj9wG6mrW3Dfb2Sid6gHz6P5ro5z4FBVZPXPjU5r2OmYN4f0jzSBSP
 mwZnNl7lsJQZwVhlrS3YdsqoXa2NH+YUh93EHFhOeOjXxy11VMiIoSVanFSdfC0w
 sfThgA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfgrhc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:36:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so4015723eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792424163; x=1793028963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7hq5nbvq3UYFK3vnPf8IbLUI7pGgpWATyJo/RjfnvO0=;
 b=QYsPmoSA3nlYnIoz5N1VgKVMqHbcdSu934WbV3C7B0UPSi4liv6xBkXXz5exiMUcF/
 o+vApQff0AtbJ3MRCutMMV0EDfn/wKDdy7x/e6cw+uL1SWFbUfyVtl1SroRhBA62bYsI
 wDp0uSSGyh9yTyft/VNNegwOMht1FoexMqL3poRaWsFhBoGX87mCjUiaCri97fbqiSww
 pfvQ7r+FQiWz1jB2s5EwUb1c1UlvYG7SBmyblTTfJNw5m2++2tvaXNrHqcZQpr3B0Lc3
 pC/MLvp8DxrIf86cwKsV+Gq+MruIoolIvAVivW/Budy1WaenEi+14qFT2rIv7HiX+TK6
 uytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424163; x=1793028963;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7hq5nbvq3UYFK3vnPf8IbLUI7pGgpWATyJo/RjfnvO0=;
 b=fPbELpZa+trMtJF/11nIcjJ97NEh8DXg415Idw1Se38G2sWawnnesM11K/x5CD2v0b
 F3RB+9+3OJbKRtJiebOzHXXd/TvIshGg/ZDVJAjRfcT4E+9QDFxpH+8OfRsgogZsMdo5
 EW6uabuwzbzdcl9QwtA3CvDyWrF1mWA053Ebecx7e1mwkWSR0+QNPnE4gfS+qc5bkZJi
 +ENliiJxky78FyldK5v5HxT7So7WgVDDUrsXA0RAEK/9Bp7TEsld7JaviQQVcsEeXwwV
 toDRAcAxKeRgk9dq3OnjB5LeUWhTWmYnjBJbhPwfNus4KIo+ans9pGhCt//w+TdNAEDw
 N+eA==
X-Gm-Message-State: AFq9FYKLzAT0WNkJXtViTIwwZ4TbzstGh6FMBEiTb8Cv7nd06motaO4j
 8pDM9sBRtO7N9Maa2DrKNpTfSk1o6DhwotYR/tC+8PLoFIMwnfDZwQqQOp1FMDK2qy6c45Fuo28
 kaqW+RUcwo5fYrfE9auFa4TT9+yw6eq9w7sjJQJd7rii2jVP4jqoecBHkHb3/RsW7Gg==
X-Gm-Gg: AYBFou2CEvrrt7I6H+iwIueis1W5V/IGN/YNcvRuBf6eZUkCp2tegtnhFgNzPP3xcai
 6I6cvHOCkPLDUTuKRmdjsqqpWSBPgAFBKGcQ1J9Gp5FRLzvjXjW3Kf4H0D5GZYWJaEjSDlAWMyI
 6jRJBfusCAZILEd+tXoZ+stlBJJ5MLv9qgAfTURma0rJTYupBeEssa1Az+NNKljhqYVHllpeFvX
 4bXnUOvp5bBPXTNZDRmN7ao5ojHnoLk5ySj84EyJ7lnIdZD/BMayLHz6dTEHnxHJKQVqm5HPcYt
 CttPXm32l2SjiWosClstEn984414kxHp9ZKQ1gT32Pc58MWmh1hGDrC6GAy78iDZVbVdAI0b69C
 CGuoT3ECPoJX1yz2b5eqSq4mRWiPiRiozbiGdMKGRthDar9Y=
X-Received: by 2002:a05:7023:907:b0:187:a2b1:7b3a with SMTP id
 a92af1059eb24-187a2b17beemr9059050c88.41.1792424162560; 
 Mon, 19 Oct 2026 08:36:02 -0700 (PDT)
X-Received: by 2002:a05:7023:907:b0:187:a2b1:7b3a with SMTP id
 a92af1059eb24-187a2b17beemr9059006c88.41.1792424161853; 
 Mon, 19 Oct 2026 08:36:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm33595924c88.4.2026.10.19.08.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:36:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/2] target/hexagon: reset implicit USR write state
Date: Mon, 19 Oct 2026 08:35:58 -0700
Message-Id: <20261019153558.2422277-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019153558.2422277-1-brian.cain@oss.qualcomm.com>
References: <20261019153558.2422277-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Ly9qv0DWVQ7J96Oqu5dhYScGZZ_gnzBg
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad638e3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6XX9eVd8KyvID48HtZQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MiBTYWx0ZWRfXwqvyJfQ/YDzh
 Y3J4dfW5nV8voL4e8zMN30DJ/Ms8tjTjzvXTZb0/1dA8Dnx4X9uBWNFElYSvyr0D6YtRZ1jPing
 jmX0cm0Fb81TtgRsalfudMjwfx8lZbGQBCVrz4JhkQYwVGZDaNw4cDDN4qtsbOck6s/81BwC4VZ
 OrpawMNC4JQGsj381vX1cMiwzznppvfoYS2XBQw4/iQhjRPTDBg4IELxW8WqKQeZsmILnff3T/q
 U5p7fiCqxi0uWy+Kng90blEiM1xBp7hPEmr3aZy4tF1EdBp4+VANEz/0DLad0DP3sD2xXDgdVin
 sNtBrzOQK8jr9naDSL4LNlWPkD5XSAhPuHlMTLyhr2eXIwB+tSNqf/a7pslxzdudC31tmjHVbL4
 1BpKz/a3Ji34LXfzBwdcSdV2dszcU6X8ayTT76kC55akFeNPt/bU4MTbAld2gP/D6OBbObm7rav
 0lryujSrSnWO8Ch/WCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MiBTYWx0ZWRfX4FQisuk3Sfsp
 efJIZ7jaWdjOOyVSloijqwmGfsfzdRTgZeTL8GDdz4NqWmqk23PXo3om2yqZSGEsTmym6h8xQsh
 7FTW6aWq2NPf5ApZis/2qvsGwh0sJCg=
X-Proofpoint-ORIG-GUID: Ly9qv0DWVQ7J96Oqu5dhYScGZZ_gnzBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190062
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aW1wbGljaXRfdXNyX3dyaXRlIGlzIHBlci1wYWNrZXQgREMgc3RhdGUuIEl0IHdhcyBub3QgY2xl
YXJlZCBiZWZvcmUKYW5hbHl6aW5nIHRoZSBuZXh0IHBhY2tldC4gUmVzZXQgaXQgdG9nZXRoZXIg
d2l0aCB0aGUgb3RoZXIgcGVyLXBhY2tldApzdGF0ZS4KCldoZW4gcnVubmluZyBxZmxvYXRfdjgx
IHVic2FuIHJlcG9ydGVkOgoKICAgIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jOjcyNTozMjog
cnVudGltZSBlcnJvcjogbG9hZCBvZiB2YWx1ZSAxOTIsCiAgICB3aGljaCBpcyBub3QgYSB2YWxp
ZCB2YWx1ZSBmb3IgdHlwZSAnX0Jvb2wnCiAgICB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYzo4
NzQ6MTI6IHJ1bnRpbWUgZXJyb3I6IGxvYWQgb2YgdmFsdWUgMTkyLAogICAgd2hpY2ggaXMgbm90
IGEgdmFsaWQgdmFsdWUgZm9yIHR5cGUgJ19Cb29sJwoKRml4ZXM6IDNlOTg0OTY2OTFlZCAoIkhl
eGFnb24gKHRhcmdldC9oZXhhZ29uKSBJbXBsaWNpdCB3cml0ZXMgdG8gVVNSIGRvbid0IGZvcmNl
IHBhY2tldCBjb21taXQiKQpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9z
cy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCAxICsKIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggMmMxOGY1ZWVi
ZmYuLmE0YzVlMDQzYzcyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNTY5LDYgKzU2OSw3IEBAIHN0YXRp
YyB2b2lkIGNsZWFyX3BrdF9jdHgoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgY3R4LT5yZWdfbG9n
X2lkeCA9IDA7CiAgICAgYml0bWFwX3plcm8oY3R4LT5yZWdzX3dyaXR0ZW4sIFRPVEFMX1BFUl9U
SFJFQURfUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVkaWNhdGVkX3JlZ3MsIFRPVEFM
X1BFUl9USFJFQURfUkVHUyk7CisgICAgY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUgPSBmYWxzZTsK
ICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+Z3JlZ19sb2dfaWR4ID0gMDsKICAg
ICBiaXRtYXBfemVybyhjdHgtPmdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVHUyk7Ci0tIAoyLjM0LjEK
Cg==

