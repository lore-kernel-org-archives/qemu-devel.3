Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92772C79F99
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2wYX-0006il-Kl; Sat, 05 Sep 2026 16:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2wYW-0006hg-2P
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:00:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2wYT-000556-5Z
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:00:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbRtx3778124
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 19:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=TBmAO9f7MBR
 xkCANznMJjMRkWHDQRr3lMtPbv/k57yw=; b=PzUxlj6UCP+n2T72Z1lYfSVm6fT
 ChzsYsjHycvURtbOHbUQXgHZq+AanItgdo/9y3mRVQK93v1Ci+a64t/ipLe47ENw
 brTcKpugZR2Y9r40RvBYXTFhuNkTpstz9U0e9DWQ6HOu0kVorXh7NPoKuSHO4Faq
 pg0aWiXBqiYQsHOlx4Ul44Bt79ycDtav7yz5DIOeQOkNHbiSfczwjpOyK7QNzgL0
 7++mJgYNrA9U2+ovNHemTxRPOQDYWigfWG3Nt7UDoALXPRMnBtE1ZlApnFWbQaOU
 b2XzFA7SGZqsp9Byfl8lJah1Q+uS0dCuECbyQBCe5CTzfM543S2YnweoR6A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga1s29ge-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 19:59:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398e1f7d1a5so3170901a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638398; x=1789243198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TBmAO9f7MBRxkCANznMJjMRkWHDQRr3lMtPbv/k57yw=;
 b=Nr4fWmsDHDbAzhRvGoS8inAySTrObMzkMv572eutY8CwnWGSodkUOrgpa5A9INA1mF
 PgzARi3Q1xS8+TCMm/3vgFo8EXCHo/6I1KzVziv8mSXbEKOoC5URlKWLsRMclY1pZI6w
 shGnXidVSiTwUL/t7ixidN4cX0xotHwWq+ymqVtTydl+m2qkmlnegdBfFlGjCcxn5Emg
 HKUuAqAO9UCrvhQXW3NpmYXz4XNUBA7S/clMu2A8z+WVi8+wk4L2IuggTHoVwE5Bv98b
 GkMi3Of4DHzF48oRnZHsoVwlCLy6Hfr/L+cD4tBdzxG07SMthv5S1S4COog+S0xb1F+m
 5hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638398; x=1789243198;
 h=content-transfer-encoding:content-type:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TBmAO9f7MBRxkCANznMJjMRkWHDQRr3lMtPbv/k57yw=;
 b=laGFwEYTWqtzdVmmEP4Wae3OJcx1cdkBlO2/NaDbKvaNVrxbjpwxfazs9qtFbf9pSp
 Oylimvmrl1k6LMiynD5JdwHLe9gmvwkFBp06LepqI2uX3qQrTeqGURFw6dArMBMvsZ+P
 ONwZ7GKsdBhKvcb8pZvlrLy5wGFNnUYTOqEoZWhWSKzeuAfGi8U4cNOlk+SLAAp7w+Zk
 J+J9BaCzUOuOvFSg/mmeZm9fpzKXhz9Q17FSEoURfsEAltlj8IEVNalPthqnTdoBm5sj
 7kMqBnBVFgaSK8Em+/ZazS+JuDnnudwq2ATt3AXrq+UgBIJtlmwJe0Tck3/NTyZkPd+O
 f+fA==
X-Gm-Message-State: AFuF++mi8vClxT1KS9U7Wh/IiRkHGx3X9FV2evep97y38XsxOfChuG6n
 pc5RqDlBeOqfWxmJtu1DHEsYL0uYbWr7Uu6nooEK5E8fN0KZOehmehYhdlvtSRjBgRvdlDDP3J4
 D7VlgzKl80WPQV7rSi6Kulwa49lttaBBpi21P6OL9yDhazxPTuOIG9dpZPJ0DIvej1Q==
X-Gm-Gg: AYBFou0jtDhWzG+pyjnG8fLG3yr0wOg1E4shS6L/jbBciQD9rj7fonSQrpMb6X8WflY
 0+OvISbRs3a6Owvu+gp/aqYGcswSwvuHJKeTnloYgj62Vv+7KrM6daRyasLSDc82Zv8FwDvPN++
 RvaxB8FhiwzdKajjXzt5hCaLops0rtcSLSNAQYGb8zRCVZdDyHOJh1dNJKOksXp9qmkWcCr/2M6
 ZSgI9ZJXoKofb2yGomT4CjzFD0C/MgVx4XC8HUyhxrBBlo7SpJHODfdYVGu8H+3XQzJEuS3OO3o
 YKVSlcyqZlcKEzcopkj8XFk0MvpM+0HhwfsS/B9PkvzJmUNhPIyxsIxKbl/jYGatLbhmuMI3JRV
 ZasgYvh+CIaFyTWa9Q+R8A6opNFTsjWgncB/Yhy5NYaEhHWke
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id
 98e67ed59e1d1-39b2624f0f4mr20582589a91.23.1788638397789; 
 Sat, 05 Sep 2026 12:59:57 -0700 (PDT)
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id
 98e67ed59e1d1-39b2624f0f4mr20582563a91.23.1788638397229; 
 Sat, 05 Sep 2026 12:59:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3342af0bc08sm14316431eec.17.2026.09.05.12.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 12:59:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 0/6] hexagon: fix HVX scatter gather, BE host
Date: Sat,  5 Sep 2026 12:59:49 -0700
Message-Id: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a9c74be cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=mpKzKNm-yqMzirWl5scA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMiBTYWx0ZWRfX4N6cEvPIqxAU
 mmtTcpyxXPNWg1DU/uxJxQvMy7exvHflzQ9kW9VokIbHMc3jAwFcWm+6OHvix/tUW/RAvjcV7k+
 qqhCXEO6MrEhlQKqR5u7Kcvm4FYhrzc=
X-Proofpoint-GUID: VUNi5Br67Zzpw_DceZ9KtUPF57fzOtkz
X-Proofpoint-ORIG-GUID: VUNi5Br67Zzpw_DceZ9KtUPF57fzOtkz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMiBTYWx0ZWRfXyBFOBxzLwJeK
 XT6vGwFCgtINRTyafFw+8vF99iQ0SfpRFRvzqbeN6tQlEpUNore5On4BnMCsBfMyuPGP5rSgDF9
 Y59TVYKlb3Pf8W3dfroYd7L6PA5hlA9UiVbpduiKn0SXTHGw+Nxe4X4FDPNh29IxgqliFBerB2A
 BptAgZIuP0INAs4WG66MR1W3JL+4FOdYgWAsSVs2lEbD7qoc++pI6bzKsosI9ElfvVxirYKbAIj
 R6WV9olpLa+J2ZsnEmJaapypX8eOQdN2Kd4INsoF45s1bKhOOr/qw7DCanNOFcMHE44lwWaoaqz
 2T++dKVgHkMhUdHPqexCoDJT8okpltvCs6DYL4XGkMeM9jrjXN2hps9l/hPKBbirvmZz50Evk/K
 Oe3Tg8XQ0yGtJd/+G/0g04WjOeDfmcWlh9Ku9c4bOvU0r4qVCtKcXvydYlh5IbqEKCTpxh+Ku14
 IV+9u9C5z7VkSEIJV9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050222
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

QW50b24gcG9pbnRlZCBvdXQgdGhpcyBlbmRpYW5uZXNzIGlzc3VlIHdpdGggSFZYLAphbmQgZm91
bmQgdGhpcyByZWdpb24gbGVuZ3RoIGlzc3VlIGFsb25nIHRoZSB3YXkuCgp2NDoKKiBBZGRlZCBh
ICdyZW5hbWUgTEVOIHRvIE9GRlNfUkVHX0VORCBpbiBWVENNIG1hY3JvcycgcGF0Y2gKCnYzOgoq
IENoYW5nZWQgdGhlIHJlZ2lvbi1sZW5ndGggdGVzdCB0byBiZSBtb3JlIGNvbnNpc3RlbnQgYmV0
d2VlbiBzY2F0dGVyCmFuZCBnYXRoZXIgYW5kIGZvY3VzaW5nIG9uIGp1c3QgaW5zaWRlLCBvdXRz
aWRlLCBiZXlvbmQgdGhlIGJvdW5kYXJ5LgoKRml4ZWQgaW4gdjI6CiogYnl0ZSBhY2Nlc3MgaGVs
cGVycyBub3cgYWxsIHVzZSBoZXhhZ29uXyBwcmVmaXguCiogUHJlZGljYXRlIGJ5dGVzIGFyZSBl
eHRyYWN0ZWQgZnJvbSAzMi1iaXQgd29yZHMgcmF0aGVyIHRoYW4gNjQtYml0IHdvcmRzLAogIG1h
dGNoaW5nIHRoZSBob3N0LW5hdGl2ZSBwcmVkaWNhdGUgbGF5b3V0LgoqIEdhdGhlciBvbmx5IHJl
YWRzIG1lbW9yeSBmb3IgbGFuZXMgdGhhdCBhcmUgYm90aCBpbiByYW5nZSBhbmQgcHJlZGljYXRl
CiAgZW5hYmxlZC4gIFNvIGRyb3BwZWQgbGFuZXMgY2Fubm90IGZhdWx0IG9yIG90aGVyd2lzZSBh
Y2Nlc3MgbWVtb3J5LgoqIFRoZSBnYXRoZXIgcmVnaW9uLWxlbmd0aCB0ZXN0IG5vdyBwbGFjZXMg
YW4gb3V0LW9mLXJhbmdlIG9mZnNldCBvbiBhbgogIGluYWNjZXNzaWJsZSBwYWdlLCB2ZXJpZnlp
bmcgdGhhdCBhIGRyb3BwZWQgbGFuZSBwZXJmb3JtcyBubyByZWFkLgoKQWRkZWQgdjIgY29tbWl0
czoKKiBmaXggZm9yIGhpc3RvZ3JhbSBwcmVkaWNhdGVzIC0gd2VyZSB1c2luZyB0aGUgd3Jvbmcg
c2l6ZQoqIHRlc3QgdG8gY292ZXIgcHJlZGljYXRlIGJ5dGUgcGVybXV0YXRpb24KCkJyaWFuIENh
aW4gKDYpOgogIHRhcmdldC9oZXhhZ29uOiBmaXggSFZYIGJpZy1lbmRpYW4gYnl0ZSBhY2Nlc3MK
ICB0YXJnZXQvaGV4YWdvbjogZml4IEhWWCBzY2F0dGVyL2dhdGhlciByZWdpb24tbGVuZ3RoIGNo
ZWNrCiAgdGVzdHMvdGNnL2hleGFnb246IGFkZCB2Z2F0aGVyL3ZzY2F0dGVyIHJlZ2lvbi1sZW5n
dGggdGVzdHMKICB0YXJnZXQvaGV4YWdvbjogZml4IEhWWCBwcmVkaWNhdGUgc2F2ZSBzaXplIGZv
ciBoaXN0b2dyYW0gb3BzCiAgdGVzdHMvdGNnL2hleGFnb246IGNoZWNrIHRoZSB0d28gSFZYIHBy
ZWRpY2F0ZSBidWlsZCBwYXRocyBhZ3JlZQogIHRhcmdldC9oZXhhZ29uOiByZW5hbWUgTEVOIHRv
IE9GRlNfUkVHX0VORCBpbiBWVENNIG1hY3JvcwoKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4
LmggICAgICAgICAgICB8ICAxMCArLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvbWFjcm9zLmggICAg
ICAgICAgIHwgMTE2ICsrKysrKysrKysrLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9t
bXZlYy5oICAgICAgICAgICAgfCAgMTggKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgICAgICAgIHwgIDE3ICstLQogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgICAgICAgICAg
ICAgICAgIHwgICAzICstCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9zeXN0ZW1fZXh0X21tdmVjLmMg
fCAgIDIgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAgICAgICB8ICAxNyAr
Ky0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgICAgICAgICAgICB8ICA0NSArKysrKysr
KwogdGVzdHMvdGNnL2hleGFnb24vc2NhdHRlcl9nYXRoZXIuYyAgICAgIHwgMTM3ICsrKysrKysr
KysrKysrKysrKysrKysrLQogOSBmaWxlcyBjaGFuZ2VkLCAyOTcgaW5zZXJ0aW9ucygrKSwgNjgg
ZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

