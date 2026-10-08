Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58A4CA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEc8T-0004cx-Lt; Wed, 07 Oct 2026 20:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8O-0004cD-DE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8L-00080I-Ri
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LuOAf1468027
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=9ZsSL2STD5aW6KxnJNd7Jz
 iBMAXnR99qPIrzzM1qMUY=; b=gemlogx98aKvcjV0Tifbz/MAm19Lg+d22ho2N5
 dF+gVgrMS3SRdKVV7vUz69lFDA1yJSLavRh7dHXjRZKQTvydqqlKedKGj91/TWFE
 2ei66rVFQt0qCc+PUbC0m3+7LSVPYelPgmc5HYZt/fEHgteGAYe/jL7ysdJJNBCb
 oyWzdwEdcrXr5D/e5rsC8RjGCb7s6eW4tjnVfWShsKqtd3m0q7kH3lWWqQvbksXV
 bpm7y8yXoDCrGmrpdUFDJ9JvSq6O9LMzrlcEIKi3KIYT0LnKM99ohgv1JxFW2pYx
 z7wBBvgEOizTDGPrx0xFHNOVcYu4s9rVzYFtMlfuvdz+W2mQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe40fuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:37:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3425098ae4bso4694462eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791419834; x=1792024634; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9ZsSL2STD5aW6KxnJNd7JziBMAXnR99qPIrzzM1qMUY=;
 b=N8PUjsS3RuFRsnx4vVpw0srGROgTLoR+6wwxceBeM1X7ESL23m/7uL4DQiJMA4eQ/i
 +x0sQhiTwizh1cUzZvpEVAaNYY5ZuY8ENYmXzBzM2QxNPn4LTHIjn6fMybiTl023FbFO
 +vgftB4aV+UZ6ISHZnL8MQF6wAXwnunk53CB0REJvFYITgWFBrXFIWfJm+vIQU0TW2iy
 jWY9st8PyhkxV0ruXsOxfHoD9VHCNi/1djcIz90Y1L21Ex8no2F1d+OzS19Guzzpca5H
 T++esM3QELNTKQ3pNcZq/GyYH1WxEwF1F2RKYsdLmSSayEmUn9rjo5hNMVNDjJu3lfEl
 /AGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791419834; x=1792024634;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9ZsSL2STD5aW6KxnJNd7JziBMAXnR99qPIrzzM1qMUY=;
 b=GB2+8m1BiHxikaEANIHWJ7a83dKgF4Fy5OImUbKJ7lzJPYi3IzlAW6m6xBx/g0Sqv1
 Qac3HhEuDY8jNER4ulytLaTjzqE35zvz40m/azMMc+gwMJqB/o4/aBbniQeNPDkxKL0o
 8lefXDYhGa8x1UBFA0vNUZNu2XKpgXoJNtLyQwhFsvcuZtOjdP/lnDQqnmPWMa4S4X4P
 +CJsLHDjauXTVxotsFO/EVfsP+inNSkWDmeZvWc9LBga+XPciZ+OwnNefj4hJbCqdHVD
 3D3O9CPEWXPHcqBiZkYTmOKC64SGIjIggBZZZiwZXO4Gb1lNfboDaZbUWxe4UHemj5bc
 IJwg==
X-Gm-Message-State: AFuF++mpQj+rWxUHJXDH+Fk+9vlE0zaem7ICIziV3d9QB7pC52WMlqGR
 yEYU1UTVFQRQyThhQ4vdmNMVTWBWiGUzvVHcpUYKq2fSe+qD7pXjidzdhpAHcUQY1Hr8veBAM87
 x1cTpHnO+/5tlnksI+awNrZfbdaBDmRe8+OgQpmN9QWeBZnuI5aoiD5WZPPvZj43LUQ==
X-Gm-Gg: AYBFou2pr0Wn/Yn9NmN2V/cFoVSODw8s5ynoO/8/kL+LpVJc+KlUqajeJ7rORkuC0zj
 Qq5ECSHaa3Fmdl3JH7/gSqxfgi/X3cSeAXEjkxpUIUcExpUgyXXsBcl24uu8kSbORAy9DG7bcYy
 ax6vA9CCyKgYRTkBdWW1GW6hF/TuyIbr6ykOJFjiRuChpJKSlJI7TCYTzb7MCPEnvRMsVwI6jlf
 rMRKAWBusbvhkkxxnUrn/z2SaZ8Lq3MmPL787puk2mmAvVTeeahzwdoZ2XqzEVD2QBao4uuNnjw
 kHSkGzvTvZZtZlrhx/h5j/9zu4FS8SKYlFD7R9ctwWbz0qeUzotQjvvbGT+zzT+LwEE0jwVYsrj
 L8reldJ64c0hFnLaxk8U5sfHTsPH+MyIV0VtCt7SLlUiRwBg=
X-Received: by 2002:a05:7022:3a8a:b0:15b:1439:1fcb with SMTP id
 a92af1059eb24-165a09b8cccmr978112c88.10.1791419834333; 
 Wed, 07 Oct 2026 17:37:14 -0700 (PDT)
X-Received: by 2002:a05:7022:3a8a:b0:15b:1439:1fcb with SMTP id
 a92af1059eb24-165a09b8cccmr978074c88.10.1791419833553; 
 Wed, 07 Oct 2026 17:37:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-163e3c5bed6sm4380048c88.7.2026.10.07.17.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 17:37:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
Subject: [PATCH v3 00/12] Hexagon: Add HVX floating point
Date: Wed,  7 Oct 2026 17:36:59 -0700
Message-Id: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: cKy1dRPuy1MG2glRClP2C8Eo2KtFKcI5
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac6e5bb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NhC41g4ciOAh6Ekn2sAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfX0/YtgLqUG5aE
 nPMe97XZDUXVXWU+b1IbtGCJ5gVWxWvBjwKGvZWICCVFM9y+H6LwYfrjOR08b3RspcsPCTzrDYq
 HtFcEIMWRRWtx2AslC/G8TfumKzzVAU=
X-Proofpoint-ORIG-GUID: cKy1dRPuy1MG2glRClP2C8Eo2KtFKcI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfXwbCPY0IfRLar
 PzKf2xTQZAxZRQO09X4BAAs3wvfaq8js4qCfbkZfd+jOBuUXZqBCHnhMDQ1NhyNBOGQyhtOtsWZ
 TC5TxqjYPZmPAktPvB2EBva0y9/l0wWXZqQDBwZTInnY4pf8qlY6yFcKCZjwZPE6yfLuEovLivu
 HGitdTSSkabYD1+Y8eLAQwnq3mhF1MAy0yoeqST/VMAhfVJS/+paCnKDXeOKc8NTm0lu0v4e44W
 j++3j/tqO2or9NWPH0H0o8MAvMnPars+BuqFC5bWGnBWVEF5+x5OURL7CzCsQ9GczacRwGrb9Pe
 /WgESHe5SpH1jEhhIJRGQHjbpH+jHf1J55y2RPbBAC+Wje1fkNWkOXUTWp09tcR8eiaIAhRBz1q
 GnuiOMe4Om1oTcL+Z4d21vo+1/vxmQHFFwfZ1o/f/uTTiZLaYtaIEkN7HYzBVbhHI38N8IQwwqD
 N9EFvR/qPAnO8I8YTyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080001
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

SFZYIGZsb2F0aW5nIHBvaW50IChha2EgUUZsb2F0KSBpcyBhIGZsb2F0IHJlcHJlc2VudGF0aW9u
IHRoYXQgY2FuIGJlIHVzZWQKYXMgYW4gYWx0ZXJuYXRpdmUgdG8gSUVFRSBmbG9hdGluZy1wb2lu
dC4gIFRoZSBjb252ZW50aW9uYWwgdXNlIGNhc2UgaXMgZm9yCmxvYWRzL3N0b3JlcyB0byB1c2Ug
SUVFRSBzaW5nbGUvaGFsZiBwcmVjaXNpb24gYW5kIGNvbXB1dGF0aW9uIGxvY2FsIHRvIHRoZQpE
U1AgdXNlcyBxZmxvYXQuCgpBbHNvOiBleHRlbmRlZC1xZmxvYXQgc2VtYW50aWNzIGFyZSBwcm92
aWRlZCBmb3Igdjc5IGFuZCBsYXRlci4KCnYzIHBhdGNoZXMgdy9vIHJldmlldzogMSwgNCwgNiwg
NywgOAoKSW4gdjM6Ci0gQWRkZWQgYSAnZGVyaXZlIEhWWCBzdG9yYWdlIHNpemVzIGZyb20gdHlw
ZXMnIHBhdGNoIHRvIG1ha2UgdGhlIGludGVudApjbGVhcmVyOyB3aGljaCBsb2dpY2FsIHNpemUg
aXMgdXNlZCBmb3IgYWxsb2NhdGlvbnMKLSBQdXQgdGhlIFZlY1JlZy1wYWlyIHNwbGl0IGluIGl0
cyBvd24gcGF0Y2ggdy9zaXplb2YoTU1WZWN0b3IpIHN0cmlkZSBhbmQKVkVDVE9SX1NJWkVfQllU
RSBwYXlsb2FkIGxlbmd0aC4KLSBVc2Ugc2l6ZW9mX2ZpZWxkKE1NVmVjdG9yLCBleHQpIGZvciBl
eHQtYml0cyBhbGxvYy9jbGVhcmluZywgaW5zdGVhZCBvZgpjYWxjdWxhdGluZyB3aXRoIE1BWF9W
RUNfU0laRV9CWVRFUy4KLSBVc2Ugc2l6ZW9mX2ZpZWxkKE1NVmVjdG9yLCB1YikgaW4gdGhlIHNj
YXR0ZXIvZ2F0aGVyIGhlbHBlcnMuCgpJbiB2MjoKLSBIVlggd3JpdGUgY29uZmxpY3RzIGFyZSBu
b3cgbG9nZ2VkIGFzIGd1ZXN0IGVycm9ycyByYXRoZXIgdGhhbiBkZWNvZGUKZmFpbHVyZXMuIHEt
cmVnIGNvbmZsaWN0cyBub3cgYmVoYXZlIGxpa2Ugdi1yZWdzOiBvbmx5IG11bHRpcGxlIHdyaXRl
cwppbmNsdWRpbmcgYW4gdW5jb25kaXRpb25hbCB3cml0ZSBjb25mbGljdC4KLSBVcGRhdGVkIHdy
aXRlLWNvbmZsaWN0IHRlc3RzOiBmb3JtZXJseSBpbGxlZ2FsIEhWWC9RLXJlZ2lzdGVyIGNhc2Vz
IG5vdwpjb250aW51ZSB3L28gZXhjZXB0aW9uLiAgVGVzdCBpbnB1dHMgYXJlIHRpZ2h0ZW5lZCB0
byB2YWxpZGF0ZSBiZWhhdmlvci4KLSBIVlggc3RvcmVzIGNvcHkgb25seSBNQVhfVkVDX1NJWkVf
QllURVMuCi0gUUZsb2F0IGZpeGVzOgogIC0gcHJlc2VydmUgZXh0IGJpdHMgd2hlbiBhIHByZWRp
Y2F0ZWQgdmVjdG9yIHdyaXRlIGlzIG5vdCB0YWtlbi4KICAtIHZjb252X2hfaGZfcm5kIGFsd2F5
cyBuZWFyZXN0LWV2ZW4sIGhhbmRsZSBOYU5zIGFzIHNpZ25lZCBJTlQxNl97TUlOLE1BWH0uCi0g
QWRkZWQgY292ZXJhZ2UgZm9yIGZhbHNlLXByZWQgZXh0LWJpdCBwcmVzZXJ2YXRpb24sIFVTUi5G
UFJORCBtb2RlcywgTmFOCmNvbnZlcnNpb24uCgpPbiB0aGUgdjEgdGhyZWFkIGJlbG93LCB0aGVy
ZSB3YXMgc29tZSBjb25mdXNpb24gcmVnYXJkaW5nIHRoZSBQUk0gYW5kCnBlcmhhcHMgdGhlIHRl
eHQgY291bGQgYmUgY2xlYXJlci4gIFdlIHdpbGwgZm9sbG93IHVwIHdpdGggdGhlIGFyY2hpdGVj
dHVyZQp0ZWFtIHRvIHNlZWsgYW4gdXBkYXRlIHRvIHRoZSBQUk0uICBJbmRlZWQsIG9uIHRoZSBy
ZWFsIGRldmljZSwKVjZfdmNvbnZfaF9oZl9ybmQgcm91bmRzIHRvIG5lYXJlc3QgZXZlbiwgaW5k
ZXBlbmRlbnQgb2YgVVNSLgoKdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
MjAyNjEwMDUwMzI2MTYuMTI5MzgyOS0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KdjE6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MjYxOTIzMzguMjcwMjk1
Mi0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENhaW4gKDEyKToKICB0YXJn
ZXQvaGV4YWdvbjogZGVyaXZlIEhWWCBzdG9yYWdlIHNpemVzIGZyb20gdHlwZXMKICB0YXJnZXQv
aGV4YWdvbjogQWxsb3cgdGVtcG9yYXJ5IEhWWCB3cml0ZSBhbmQgZnV0dXJlIHdyaXRlCiAgdGVz
dHMvdGNnL2hleGFnb246IENvdmVyIEhWWCB2ZWN0b3Igd3JpdGUgY29uZmxpY3RzCiAgdGFyZ2V0
L2hleGFnb246IGFkZCB2ODEgSFZYIGNvbXBhcmUsIGFsaWduLCBhbmQgY29udmVydCBpbnN0cnVj
dGlvbnMKICB0YXJnZXQvaGV4YWdvbjogZml4IFY2X3ZjbW92IHJlc2VydmVkLWJpdCBlbmNvZGlu
ZwogIHRhcmdldC9oZXhhZ29uOiB1c2UgdmVjdG9yIHBheWxvYWQgc2l6ZSBmb3IgSFZYIG9wZXJh
dGlvbnMKICB0YXJnZXQvaGV4YWdvbjogdXNlIG9iamVjdCBzdHJpZGUgZm9yIEhWWCBwYWlyIG9w
ZXJhdGlvbnMKICB0YXJnZXQvaGV4YWdvbjogcmVzZXJ2ZSBpbnRlcm5hbCBIVlggdmVjdG9yIHN0
YXRlIGZvciBRRmxvYXQKICB0YXJnZXQvaGV4YWdvbjogYWRkIHRoZSBRRmxvYXQgbG9naWMKICB0
YXJnZXQvaGV4YWdvbjogc2VsZWN0IFFGbG9hdCBpbnN0IHNlbWFudGljcyBieSByZXYKICBsaW51
eC11c2VyL2hleGFnb246IGFkZCB2NzUtdjgxIEhXQ0FQcwogIHRlc3RzL3RjZy9oZXhhZ29uOiBh
ZGQgdjgxLCBleHQtUUZsb2F0IHRlc3RzCgogZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24u
cnN0ICAgICAgICAgICAgfCAgIDggKy0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICAyICstCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oICAgICAg
ICAgICAgICAgICB8IDI0MiArKystLS0KIHRhcmdldC9oZXhhZ29uL21tdmVjL2h2eF9pZWVlX2Zw
LmggICAgICAgICAgIHwgICAzICsKIHRhcmdldC9oZXhhZ29uL21tdmVjL21hY3Jvcy5oICAgICAg
ICAgICAgICAgIHwgMTE5ICsrLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvbW12ZWMuaCAgICAgICAg
ICAgICAgICAgfCAgOTQgKystCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9tbXZlY19xZmxvYXQuaCAg
ICAgICAgICB8IDEzMyArKysKIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAg
ICAgICAgIHwgIDIwICstCiB0YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyAgICAg
ICAgICB8ICAgMiArCiBody9oZXhhZ29uL2hleGFnb25faHZ4X2NvbnRleHQuYyAgICAgICAgICAg
ICB8ICAgNSArCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jICAgICAgICAgICAgICAgICB8
ICAgOSArCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAx
MiArLQogdGFyZ2V0L2hleGFnb24vZ2Ric3R1Yi5jICAgICAgICAgICAgICAgICAgICAgfCAgIDQg
Ky0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICAgICAgIHwgIDE4ICst
CiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfaWVlZV9mcC5jICAgICAgICAgICB8ICAyNCArCiB0
YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0LmMgICAgICAgICAgICB8IDgzMSArKysrKysr
KysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMgICAg
ICB8ICAxNCArLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAgICAgICAgICAg
fCAgMzQgKy0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgIHwg
IDMxICstCiB0ZXN0cy90Y2cvaGV4YWdvbi9jaGVja19yZXZfZ2F0aW5nLmMgICAgICAgICB8ICAx
MiArLQogdGVzdHMvdGNnL2hleGFnb24vaHZ4X2V4dC5jICAgICAgICAgICAgICAgICAgfCAyNDgg
KysrKysrCiB0ZXN0cy90Y2cvaGV4YWdvbi9tdWx0aXBsZS13cml0ZXMuYyAgICAgICAgICB8IDEw
NyArKy0KIHRlc3RzL3RjZy9oZXhhZ29uL3FmbG9hdF92ODEuYyAgICAgICAgICAgICAgIHwgMTE5
ICsrKwogdGVzdHMvdGNnL2hleGFnb24vdjgxX2h2eC5jICAgICAgICAgICAgICAgICAgfCAyNTkg
KysrKysrCiB0YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMgICAgICAgICAgICB8ICA1
NCArKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weSAgICAgICAgICAgICAgfCAgIDIg
Ky0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgICAgICAgICAgICAgICAgIHwgIDk2ICsr
LQogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbW12ZWMvZW5jb2RlX2V4dC5kZWYgfCAgNjMgKy0K
IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21tdmVjL2V4dC5pZGVmICAgICAgIHwgMjM1ICsrKysr
KwogdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgfCAgIDEgKwog
dGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgfCAgMjUgKwogMzEg
ZmlsZXMgY2hhbmdlZCwgMjU5OSBpbnNlcnRpb25zKCspLCAyMjcgZGVsZXRpb25zKC0pCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vbW12ZWMvbW12ZWNfcWZsb2F0LmgKIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9tbXZlYy9odnhfcWZsb2F0LmMKIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9odnhfZXh0LmMKIGNyZWF0ZSBtb2RlIDEwMDY0
NCB0ZXN0cy90Y2cvaGV4YWdvbi9xZmxvYXRfdjgxLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0
cy90Y2cvaGV4YWdvbi92ODFfaHZ4LmMKCi0tIAoyLjM0LjEKCg==

