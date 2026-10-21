Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAD606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aDR0xGKW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fi78Qa0/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKP0-0002BA-78; Tue, 20 Oct 2026 20:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKOx-0002Aq-CQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:41:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKOv-0006yx-OO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:41:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKth2h1716840
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=; b=aDR0xGKWjeYOkLre
 7kFT0Q5S8C9DzMKqlTeiOeqjZEJjVQzBOmKQn7V6zoZPVoF5O1rXTNwn5sYkDDcH
 ppJAtXscYQaf1/0BKcTqOCnEgq1Wa4GWHrqSa+coYOnK6s/lslGOc9JJXf9xS4DR
 PUrFmjJ5ouL8gTOju8jKpgOYgLwtLNRcwNQ4HbGJdRemYTvUG7keCC6DSaWz0r9Q
 rHSB/XZ0taKyg4p0gGSjBp+E2sokV1/GiliaF9LmorPPPIoEkluWPXrhWvF2nVnB
 IuaUkee45hToGNy+SWpWzHmJUaUYwaGSaiPSB3iDgx85GUp6gStTKHODEh6bPl7F
 b2LaWg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9903n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:41:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so361078eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792543312; x=1793148112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=fi78Qa0/JPa4SrqrVJuV5kzPZ/dHQimFKcjyO43lMyxa3j2gGdO09gQIuKBHqvdkC/
 0FSr/3EYlxc2ufP9LfuzibGN60Cfk5yQfPshVyUp5PoQf+PRgIFk6ygSqJvtcqkl+SkJ
 GTrqmg442cehvNf4Ly+cN1IFPnhPdzOzLgxR+k30HyAdzr3Nh9H/HO9bOpPsIbh9VPVl
 TaUY1AbOkBe6CXqQHM7lWmXJXbiuJ/FpnfQbluxK07Z1JcKExa40s3bzY31SnSk7LZLF
 fRmzUM4eXTaLPTZYrb6/gIzfL3bdqhDJoq9uFyVCKTgv0CgTsiCLwqG+37ax16RcDfak
 Y8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792543312; x=1793148112;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mC8jl7vyVvYi+vhoijubMe1xPjMvd4/tlNPZMUbwGZ8=;
 b=zs15ung1ZklG5TWO3W/uWV4+ag5Bg6E1lD/QNHjJ8tVp5m5np0GPxJG3uDPlosfn/K
 LLMss1Nwrgb6KNwbCGrd15Ml4/5tfLxG8wU9njmwoeNkv7+ThFRmc2O0Aspgytq19pNR
 p+koKSfz2IEvIEIirPajtemoRSwkygZdpnKw5DVTruLPaOuzTrkug/Dwr/jU/sotMUsY
 rhY4lKivvbtE6aMnuWH/XRZf0nYcKQqdAN6pTOJRWnw1cvs+BSiPOr+3KH9wKqPb7ViV
 8BPEX19Ds13k3Q1kC9zrqXhylHl+vWpNEwPUnjEHyynnytxJe2LG5lg3UyOTmaDrCRI4
 YdfA==
X-Gm-Message-State: AFq9FYJOJxu6ne6ALOwJ+T6XpkX9/m890MUz29d37VkT0WkR35dhMlMf
 B+jcCZYoWNDXBELuRsAcZGPaPDZUeanddYc+wmZ4FUmBlnegGIAYfJRckFrNsUitT+wdGyEqLyT
 0UweLpdbhgHYz8EtvxkiUo0OmX4L/kVPxUFZFaNvVKtp23XE8Rm4KvP48TOngtwZRpQ==
X-Gm-Gg: AYBFou2O4o7TJHwzA15/AolPSPhd84JN0+8ZHMg2wvmNjtU/k9jKFIpHi2ex+cLFXLY
 +2LDHwJRzRVQ3TbRoOJizL9mpOfUE+sYwNRWiJ3ff5iTI+PNZAiD+cH2WLmxsFFwcGy8lyYzL8T
 0yX9MBC9QjOdYVKAH6kl3oARM/DmHiDaDjq+1kmsccZco8t3VBXnfNMXzZxOACM3BHcV2qC3JFc
 i0/en1+1nLO1EjOoOeNeX+AF48y26pZ2L35AO/nx218oadH6e7p1cp9DIChonf2t9UaDGAfNAQI
 Q+YKwnKenVNPicDgwNaoBZcXZZUg72UyBc4Oncyxn/E4JkXhO86GFPvmwy0ieq+T1jc4pidjZQ1
 02zj9XSzUGiR/kZOWPKkXKF7uwhwbIAWjOWlAsoWthLFOG0E=
X-Received: by 2002:a05:7022:f908:b0:144:e246:a0b5 with SMTP id
 a92af1059eb24-190a7380badmr476556c88.40.1792543311565; 
 Tue, 20 Oct 2026 17:41:51 -0700 (PDT)
X-Received: by 2002:a05:7022:f908:b0:144:e246:a0b5 with SMTP id
 a92af1059eb24-190a7380badmr476546c88.40.1792543310988; 
 Tue, 20 Oct 2026 17:41:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d87ab1bsm2005788c88.21.2026.10.20.17.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 17:41:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Alessandro Di Federico <ale@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 02/15] linux-user/hexagon: report ISA HWCAP through v85
Date: Tue, 20 Oct 2026 17:41:32 -0700
Message-Id: <20261021004145.1693260-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
References: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXylLNkqu3IMod
 QK614EJw/4WdXBePPkgxxupgUTpRXhbEiVqHR5AQn5Pfir67uoU4dhEJRsmEtZVdNkqC1qomEz/
 diatoGo9ZWgwiSGGhTjycit+z1zjja4=
X-Proofpoint-GUID: FV19mToQ1sMQ9Lay54eZf0PsmQfho9tv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX8WKgca0iiXpf
 kzEsmu4zS7T2C1IgIANGQvDRpn8qv7xGfD0HITH/52nqPiCHQt7APKB7rX+mH2/5sSQq2ko8pcH
 CC1Oup8O4CuVqQYATL5IFoHVYV963Rp8gfhxfYEhzd3fanwHGbecSyO0SuqJP0Q559YQxnoG7Co
 5TYB4abJHktUqOwiDgOoDRDUuwM0HL37m9RAZVZ3YTETmLbGdlDGoIT6ALIGTdFp/4ic9SFgSYf
 veF2NYds9k054Iux0C6jrHSFy3QU7rTSmU6SoHLZE/C7CrYOBAjgYHhoDt9tOuPmLOZHpkN4qoC
 Eoac4iQKM5Mbt/XivUoobhH2hOFRT1woC4URnCODT2NmsZrxp2OX2ldUgCB8j7ljBRVo+wTor/v
 RJcYtHtA/S+5rghAJrNzD/8bgySnodzEd3QEBz7ibIAlxUAFABcIW8yvygMjlkifBlxTMX1Yem2
 HXrTC2PwRvdaPF0ZEoA==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad80a50 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=RcCyqxnK1iORyYYg75cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: FV19mToQ1sMQ9Lay54eZf0PsmQfho9tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210001
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oIHwgMiArKwogbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyAgICB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi90YXJnZXRf
ZWxmLmggYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCmluZGV4IDkwZTUwMzJkNWFh
Li5iMWViNWVhNTAzNyAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL3RhcmdldF9lbGYu
aAorKysgYi9saW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2VsZi5oCkBAIC00Myw2ICs0Myw4IEBA
IGVudW0gewogICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y3NyAgICAgICAgICAgPSAxNiwKICAgICBI
V0NBUF9IRVhBR09OX0lTQV9WNzkgICAgICAgICAgID0gMTcsCiAgICAgSFdDQVBfSEVYQUdPTl9J
U0FfVjgxICAgICAgICAgICA9IDE4LAorICAgIEhXQ0FQX0hFWEFHT05fSVNBX1Y4MyAgICAgICAg
ICAgPSAxOSwKKyAgICBIV0NBUF9IRVhBR09OX0lTQV9WODUgICAgICAgICAgID0gMjAsCiAgICAg
SFdDQVBfSEVYQUdPTl9IVlggICAgICAgICAgICAgICA9IDEgPDwgNywKICAgICBIV0NBUF9IRVhB
R09OX0NBQkFDICAgICAgICAgICAgID0gMSA8PCA4LAogICAgIEhXQ0FQX0hFWEFHT05fSFZYX0xF
TkdUSF8xMjhCICAgPSAxIDw8IDksCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vZWxm
bG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA5Zjk4YWQ4ZmI4Ni4u
ZGIwYmYyOTljYzAgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKKysr
IGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNjIsNiArNjIsMTIgQEAgYWJpX3Vs
b25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WODE6CiAg
ICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKICAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSBIRVhfVkVSX1Y4MzoKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9JU0Ff
VjgzOworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjg1OgorICAgICAgICBod2Nh
cHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WODU7CisgICAgICAgIGJyZWFrOwogICAgIGRlZmF1bHQ6
CiAgICAgICAgIHJldHVybiAwOwogICAgIH0KLS0gCjIuMzQuMQoK

