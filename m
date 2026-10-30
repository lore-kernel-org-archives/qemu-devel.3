Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A97606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C27Iv0v+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AkMvVyL5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMcYu-00047d-As; Thu, 29 Oct 2026 22:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYj-000459-Sd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMcYT-0005sy-DC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:41:24 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U2Jqv7992115
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HqD3H+v0Z6/DezOAkWUA4PTMmTcElEFhQEdj3hRuvBs=; b=C27Iv0v+qBajNqxf
 jhgoHZa3EsC4cPRPFvxx4LYRtOjEKL0VNmD8BP0kU5YCl8c2NfAipw+TtwZNRxOY
 XGcJOt+UcZAnjcpsOWZGYo6Japhsr1MN6/UoSZ+gfbUqE+pir2IZ13xZdkwqe+7f
 Fb6s5P3pcnw6FMdFkr1hQzaWNUXQMs/2t5j5CRPT0GfDyDBQow+HIiM8gcOp2BCh
 oXyAoWFeCnnxa7ojFIMY5Md5JMSeqy5OiX/I8TZ2rdeBN37Wei9VVkSCiGuAqLIt
 ILn7E3e9EisZWaqH7SRU3LVHOHGaOo53U5CEU3uG05vFhz+d4iuGd1umrlgWfIp6
 Nt7Pnw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p8u97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:41:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso359950eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793328078; x=1793932878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HqD3H+v0Z6/DezOAkWUA4PTMmTcElEFhQEdj3hRuvBs=;
 b=AkMvVyL5QWZM4yLlF8XyYf9h/xgRG8/Dme7l9nYG1CTA4eO8O9MACm7suR2Rg8dAzC
 /Fr4trErMcYbpFN1pZnWFZfviFG5+67YsZCxkHe8utrBd0i1zRhLfjcQbGn/WxiQ4ai6
 zKMriIXRwTNZ7ScKMhjqgOlJYuyIK2EIOZgKO9M7SOE8hy9cFbDaqHrpaHxZN8DhZdvw
 B93/a8EJ4H21FUQLf9N1QAdy3kLvka5Hkg7+becCtni23h814YRuH+f7MLKFM9cCOgZv
 wHvPIEUXzJMSthkXpfL+wX5V+AR8qXa+RxmQID8Hov3Z/tNLS55PUMYsDLoIpSu63Xd/
 Rlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793328078; x=1793932878;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HqD3H+v0Z6/DezOAkWUA4PTMmTcElEFhQEdj3hRuvBs=;
 b=0/HSz0bcb/AOgBwBMs4E1Qh96gVo8fHQpDNzltZcaa0kRlVlQ83egpFpGw6AKQSsw6
 YyWL2RKNac6ouwRF/D1r+1DD3elr0aaCFQOVXiTRyik9dp7DwocfuToXI31Lu4C3N4Vc
 H3ykXFXHyOqOf2Pb4YtZjbyAOm+YYbFkpRJO0dwMqUp11QBNaLwCofvQHSvPkGvewJzR
 xTkaW8/GWBqiU3mcTU34sNmHwsem/jZPBX4qF6FAJvPWzrtzwhYexa4yWJePBjinlox9
 o/6IyohHGbIPCFDmiNd7oeeor+/RO9LG2NY2rsteTtX8yQnyhzUGkpBFotB+DW5DFYgi
 3RgQ==
X-Gm-Message-State: AFq9FYJSoTHo/mC9uJsn+nUcOPiQSKo4CvY4cQr+nceDgTa4tGI0kFBm
 RsjPvkARkBMqSYz4Kn0E+0zYf4FMsnhxChYQZUEDdh2mLnjaH6Cs3ZYIXXAngJxOs+AqwmxM9EO
 oAR+Ok3OIc/YQp11ClfsHj821AB0seEhLlKB8EDswKghIWjwJmjfgI+Ya4N+6yYoxQQ==
X-Gm-Gg: AYBFou2+xpZTcMCnEclL8IWtPlMF88GjdTXuHIAVdFEaounAHBby6/SRz5uEQ4bbnCl
 1+ID7QFKghQJAy2Cb7ChNZ7OXtUadm54C6l3WGOaJyXjrlSe7XO+GpaQWtXNgu0n+0YtyoO0LSn
 vtTpgcTnAY+QdeTCi5L1X6dwwQKar0fXoJA7gnI2QXokOWja6x9UgMPXQHxRdiqVzGHBJv//oyN
 LMrbEx4V8NDp+dcqBP+2mLGBZy28mjlFyYcTR65RZpjSYO0diK51xi2/O3AOgU96ZL5VonYhlAu
 xhiUW+y4y8TEG3308SaHO2hrWqMZ1Lg4Fsy885TqiSQ8bLuPTETFfgsTiipp/Usuw0h/g3Q0jJl
 J1HDnEIl9yU3MH2cAlrsPMlhGmwm4iOv7mi5LumaAnkoM0ZusevjxByZgU6W7joYp+UmCyljzNV
 gemQbMPJn5hfFYdvXvYCqhew==
X-Received: by 2002:a05:693c:835c:20b0:36a:30b:5dc0 with SMTP id
 5a478bee46e88-36a423c338dmr1631364eec.24.1793328077863; 
 Thu, 29 Oct 2026 19:41:17 -0700 (PDT)
X-Received: by 2002:a05:693c:835c:20b0:36a:30b:5dc0 with SMTP id
 5a478bee46e88-36a423c338dmr1631332eec.24.1793328077192; 
 Thu, 29 Oct 2026 19:41:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm2704624eec.18.2026.10.29.19.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:41:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 5/8] target/hexagon: gate HMX exec on SSR:XE2
Date: Thu, 29 Oct 2026 19:41:07 -0700
Message-Id: <20261030024110.1986536-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX0tozRtTV35u1
 iR5JKZbVgOWpRYPRqoS4GGIWCQSpb5nM+tvcRetHCN4Zkli70jJBUMVEL1dt7/yHdcwthOwF2Wu
 1HXB3Qw4e/bLJPLDbkEtR1LbRFg7MPueg1Uonv3ttMe5YtFo8ZAQ+sOuV2f3gaM89EvYaSsxUeI
 QsMCssWD+z6sSXqmKwPlPjTvmAw6nsWzNeerzRn63p2mWEbOxNMT5HpDl4UGGPBugTKMjKeu2Qw
 3WDcbSa2M34ZxxaijyjEHOnKxTBKL8tA9h/FKvu8HpdjlEvarU5ddaja1kVHzSa27YI5BYbFNxR
 V0HA2R6d4w9DpNd21JlIOadv0lhL69BD/aRBZhdu+arMU/aAjsRtWeV8S5p9+E6xRcBNy8TQGqt
 vSZY1w7+5XraWLHSxuPPrfS84vgpdTBgXpYzKbVs1SNvWbHXHtRll/gUDwvBJxm2Kvn/O0RnSCt
 DWsJqPBLG358xzGROjg==
X-Proofpoint-GUID: aoEaMNNKsjXABzg96DfHaK3XFNt3rEoO
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae403ce cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=OCf9wL_4i7BUJax0SAUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: aoEaMNNKsjXABzg96DfHaK3XFNt3rEoO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAxMCBTYWx0ZWRfX8ItYXGfe9ssY
 Yuy6cpdcRhQ2FYcffzVRFd9wAH5vFxPWnVw11/4lBgMSVsbSLhz4x2x6bC7GdvN3ssJkcSxN6sB
 zG1nqpdkG//pEq8gllFQZqTze8ZWzho=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300010
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

RXhlY3V0aW5nIGFuIEhNWCBpbnN0cnVjdGlvbiB3aXRoIFNTUjpYRTIgY2xlYXIgcmFpc2VzIGEg
Tk9fQ09QUk9DMl9FTkFCTEUKZXhjZXB0aW9uLgoKTG9nIHBhY2tldHMgb25lIGFzIExPR19VTklN
UCBmb3Igbm93LgoKUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5x
dWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAg
ICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2luc24uaCAgICAgICAgICAgICAgICAgICAgIHwgIDEg
KwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgICAgfCAgMiArKwogdGFy
Z2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMiArKwogdGFyZ2V0L2hl
eGFnb24vZGVjb2RlLmMgICAgICAgICAgICAgICAgICAgfCAgMyArKysKIHRhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgIHwgMjEgKysrKysrKysrKysrKysrKysrKysrCiB0
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8ICAzICsrKwogNyBmaWxl
cyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmggYi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCAyMmFhMTYzMDc2Ny4uMWNkZmY1ODNk
YTQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29u
L2NwdS5oCkBAIC0yNDcsNiArMjQ3LDcgQEAgRklFTEQoVEJfRkxBR1MsIE1NVV9JTkRFWCwgMSwg
MykKIEZJRUxEKFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VOQUJMRUQsIDUsIDEpCiBGSUVMRChUQl9G
TEFHUywgQ1BVX01PREUsIDYsIDIpCiBGSUVMRChUQl9GTEFHUywgU1NfQUNUSVZFLCA4LCAxKQor
RklFTEQoVEJfRkxBR1MsIEhNWF9DT1BST0NfRU5BQkxFRCwgMTUsIDEpCiAKIEdfTk9SRVRVUk4g
dm9pZCBoZXhhZ29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGV4Y2Vw
dGlvbiwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2luc24uaCBiL3RhcmdldC9oZXhhZ29u
L2luc24uaAppbmRleCA1ZDU5NDMwZGE5ZS4uYWZhZTkyOGU2NzkgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2luc24uaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnNuLmgKQEAgLTcwLDYgKzcw
LDcgQEAgc3RydWN0IFBhY2tldCB7CiAgICAgYm9vbCBwa3RfaGFzX3NjYWxhcl9zdG9yZV9zMTsK
IAogICAgIGJvb2wgcGt0X2hhc19odng7CisgICAgYm9vbCBwa3RfaGFzX2hteDsKICAgICBJbnNu
ICp2aGlzdF9pbnNuOwogCiAgICAgSW5zbiBpbnNuW0lOU1RSVUNUSU9OU19NQVhdOwpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuaAppbmRleCBiYzVmMjAyMTYzZi4uODhiOTQ4ZTg2NjkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC0x
MDEsNiArMTAxLDggQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBUQ0d2IGRj
emVyb19hZGRyOwogICAgIGJvb2wgaHZ4X2NvcHJvY19lbmFibGVkOwogICAgIGJvb2wgaHZ4X2No
ZWNrX2VtaXR0ZWQ7CisgICAgYm9vbCBobXhfY29wcm9jX2VuYWJsZWQ7CisgICAgYm9vbCBobXhf
Y2hlY2tfZW1pdHRlZDsKIH0gRGlzYXNDb250ZXh0OwogCiBib29sIGlzX2dhdGhlcl9zdG9yZV9p
bnNuKERpc2FzQ29udGV4dCAqY3R4KTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
IGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggODNlMjM3NzVlYTIuLjFiZmI5NDgyMjdiIDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUu
YwpAQCAtMzkzLDYgKzM5Myw4IEBAIHN0YXRpYyBUQ0dUQkNQVVN0YXRlIGhleGFnb25fZ2V0X3Ri
X2NwdV9zdGF0ZShDUFVTdGF0ZSAqY3MpCiAgICAgaGV4X2ZsYWdzID0gRklFTERfRFAzMihoZXhf
ZmxhZ3MsIFRCX0ZMQUdTLCBTU19BQ1RJVkUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBH
RVRfU1NSX0ZJRUxEKFNTUl9TUywgZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkgJiYKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdldF9jcHVfbW9kZShlbnYpICE9IEhFWF9DUFVfTU9ERV9N
T05JVE9SKTsKKyAgICBoZXhfZmxhZ3MgPSBGSUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1Ms
IEhNWF9DT1BST0NfRU5BQkxFRCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgIEdFVF9TU1Jf
RklFTEQoU1NSX1hFMiwgZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkpOwogI2Vsc2UKICAgICBo
ZXhfZmxhZ3MgPSBGSUVMRF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1NVV9JTkRFWCwgTU1V
X1VTRVJfSURYKTsKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMg
Yi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwppbmRleCAwYWM4N2JiZWUwYy4uMjkxNmU0YzY4ZGYg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L2RlY29kZS5jCkBAIC03NzMsOSArNzczLDEyIEBAIGludCBkZWNvZGVfcGFja2V0KERpc2FzQ29u
dGV4dCAqY3R4LCBpbnQgbWF4X3dvcmRzLCBjb25zdCB1aW50MzJfdCAqd29yZHMsCiAKICAgICBw
a3QtPmVuY29kX3BrdF9zaXplX2luX2J5dGVzID0gd29yZHNfcmVhZCAqIDQ7CiAgICAgcGt0LT5w
a3RfaGFzX2h2eCA9IGZhbHNlOworICAgIHBrdC0+cGt0X2hhc19obXggPSBmYWxzZTsKICAgICBm
b3IgKGkgPSAwOyBpIDwgbnVtX2luc25zOyBpKyspIHsKICAgICAgICAgcGt0LT5wa3RfaGFzX2h2
eCB8PQogICAgICAgICAgICAgR0VUX0FUVFJJQihwa3QtPmluc25baV0ub3Bjb2RlLCBBX0NWSSk7
CisgICAgICAgIHBrdC0+cGt0X2hhc19obXggfD0KKyAgICAgICAgICAgIEdFVF9BVFRSSUIocGt0
LT5pbnNuW2ldLm9wY29kZSwgQV9ITVgpOwogICAgIH0KIAogICAgIC8qCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmlu
ZGV4IDkxOTI1ZDJkZGIxLi40Yzg0ZmVhZWViNSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTg2MCw2ICs4
NjAsMjQgQEAgc3RhdGljIHZvaWQgZ2VuX3N0YXJ0X3BhY2tldChEaXNhc0NvbnRleHQgKmN0eCkK
ICAgICAgICAgY3R4LT5odnhfY2hlY2tfZW1pdHRlZCA9IHRydWU7CiAgICAgfQogI2VuZGlmCisK
KyAgICBpZiAoY3R4LT5wa3QucGt0X2hhc19obXgpIHsKKyAgICAgICAgZm9yIChpID0gMDsgaSA8
IGN0eC0+cGt0Lm51bV9pbnNuczsgaSsrKSB7CisgICAgICAgICAgICBpZiAoR0VUX0FUVFJJQihj
dHgtPnBrdC5pbnNuW2ldLm9wY29kZSwgQV9ITVgpKSB7CisgICAgICAgICAgICAgICAgcWVtdV9s
b2dfbWFzayhMT0dfVU5JTVAsICInJXMnIGlzIG5vdCBpbXBsZW1lbnRlZFxuIiwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG9wY29kZV9uYW1lc1tjdHgtPnBrdC5pbnNuW2ldLm9wY29k
ZV0pOworICAgICAgICAgICAgfQorICAgICAgICB9CisgICAgfQorCisjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKKyAgICAvKiBITVggbmVlZHMgU1NSOlhFMiAqLworICAgIGlmIChjdHgtPnBrdC5w
a3RfaGFzX2hteCAmJiAhY3R4LT5obXhfY29wcm9jX2VuYWJsZWQgJiYKKyAgICAgICAgIWN0eC0+
aG14X2NoZWNrX2VtaXR0ZWQpIHsKKyAgICAgICAgZ2VuX3ByZWNpc2VfZXhjZXB0aW9uKEhFWF9D
QVVTRV9OT19DT1BST0MyX0VOQUJMRSwgY3R4LT5wa3QucGMpOworICAgICAgICBjdHgtPmhteF9j
aGVja19lbWl0dGVkID0gdHJ1ZTsKKyAgICB9CisjZW5kaWYKIH0KIAogYm9vbCBpc19nYXRoZXJf
c3RvcmVfaW5zbihEaXNhc0NvbnRleHQgKmN0eCkKQEAgLTE0MzQsNiArMTQ1Miw5IEBAIHN0YXRp
YyB2b2lkIGhleGFnb25fdHJfaW5pdF9kaXNhc19jb250ZXh0KERpc2FzQ29udGV4dEJhc2UgKmRj
YmFzZSwKICAgICAgICAgY3R4LT5iYXNlLm1heF9pbnNucyA9IDE7CiAgICAgICAgIGN0eC0+aXNf
dGlnaHRfbG9vcCA9IGZhbHNlOwogICAgIH0KKyAgICBjdHgtPmhteF9jb3Byb2NfZW5hYmxlZCA9
CisgICAgICAgIEZJRUxEX0VYMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSE1YX0NPUFJPQ19FTkFC
TEVEKTsKKyAgICBjdHgtPmhteF9jaGVja19lbWl0dGVkID0gZmFsc2U7CiAjZW5kaWYKIH0KIApk
aWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgYi90
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQppbmRleCAxYzFkNTQ0MGJi
Ni4uZDNmOWI5NWQ5NjEgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0
X3N5c3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3Rz
LnB5CkBAIC05MCw2ICs5MCw5IEBAIGRlZiB0ZXN0X2FjY2VzcyhzZWxmKToKICAgICBkZWYgdGVz
dF9zZW1paG9zdChzZWxmKToKICAgICAgICAgc2VsZi5ydW5fY29uc29sZV9wYXR0ZXJuKCJzZW1p
aG9zdCIsICJQQVNTIiwgIi1hcHBlbmQiLCAiYXJnMSIsICJhcmcyIikKIAorICAgIGRlZiB0ZXN0
X2ludmFsaWRfaG14KHNlbGYpOgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImludmFsaWRf
aG14IikKKwogICAgIGRlZiB0ZXN0X2R0Z19pbnRlcnJ1cHQoc2VsZik6CiAgICAgICAgIHNlbGYu
cnVuX2V4aXRfemVybygiZHRnX2ludGVycnVwdCIpCiAKLS0gCjIuMzQuMQoK

