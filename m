Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7398606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gFxi8vUU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A+Jv4/VP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMumP-0000fe-QY; Fri, 30 Oct 2026 18:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumO-0000f6-2w
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumM-0003qO-77
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtTD61349873
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hJpwr7WWtEPrQ9wXi2XItcrqDItbydKRZWcy7c84MHU=; b=gFxi8vUU+YqUQUHr
 N01nosWtsRZPIyKM2bYe9XD62iU5V4AahcNBsI32Gz2s0YSf490VKlKmWxcAbvk6
 fAWUdofRYnE+Fzm6w/Vyq4EnJOMMPnbflYhaQNBR2MbeELDd7jE9L+EnlC8zH8jt
 L4++osowL9IRcJb8iWINcayTCnDOyGp/evnoGFSaNgAs8xBrgzbpD8iMce2pTUik
 9BhPZUXNDktY9H9xHuz2ORynUX0GDvwNRhYlP4qCD3Vs+HCf3r+kvywj07h+/vVy
 X3e7ZpAVAT/RbPzNSERBrEpBRDKUHqendcjBwlI437RTMmf/mTAt/kDbCdD89kUm
 BtAnfQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x005w4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso1827375c88.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398132; x=1794002932; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hJpwr7WWtEPrQ9wXi2XItcrqDItbydKRZWcy7c84MHU=;
 b=A+Jv4/VPbskWaOirnB57O+q1Q7jKXwnyWZ/b+JM6Rz0cOrYzCzqQE5roGkLi933HOf
 Orz43jsPr5+A2xRMyp+Hqle2MHCPqHQsXlVPP82PdBl6Ru/CO+xDaJODMWwPSp4uDwx+
 JrGEXwzsRNJR2NQ8NdtImU0UPurCeoyeG3bGSp8vPvEeLNMe6lQNMVEaxbgbr1WQES+l
 RyPZACgG+M3Dr11ZGBSwW148UMs4wek20DrXD1zMBnef+DJAUQAle/ZJOaNYsLeBBvnY
 2jxk8CGH3N7Pngl8R1hTBAdNJTyeAxEXx0mcIWAga6F+Lv2UvksjFBxaf9iN31N4HxOP
 MlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398132; x=1794002932;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hJpwr7WWtEPrQ9wXi2XItcrqDItbydKRZWcy7c84MHU=;
 b=DCnEvG8mFawv0KYjLSBrNM4rnr1yvhR6XriePbBJjznQnZhnfWOsGI5+emEOJZQvWs
 VMM1yTOmy59OWLpVcJdkgfD15VdDBS3QgAEgaP/NqpDZwlXmf4DRQ6NaWHEXkRWiPTLJ
 6ueVE3v+11fPLzHr/pLQ6AJa+QJQwOfHWOHZgoZOIyqucZLVZj377NXpMiosOwiwI2rc
 FgJH4bzwxfjrg8cqeUgAiZ2nAPhNesGSQN/S0qTw2p5Gmf8exjv0CRq5jaGqumamb/JZ
 UHIwqFCXu3fqYdNfkferrWRaA7vhP4QY1QC//HZO0w5lCwg30+dQfoOnWV4zbcEz1D6T
 qRbg==
X-Gm-Message-State: AFq9FYLAmq/2nHalJ8VbCHnDzV9pVbJvzDFwQLtUiQGQV4WcYbPkU57x
 3A1SXNL6XJZKqIVTgtTBRCfjygWiXqLvtn6DczhPYYEXXjdmxVDbLms+EFsCl4f1gObl0hndf8k
 5+0JqyIu84S7uPHk2ACGcYkQPAMaWdqWT3jnm0lU68nGkWxoHW4NTdGL4GDhEdoqaqQ==
X-Gm-Gg: AYBFou0GYG1gFklGpQRDFVzHJrX08CPMBGUqqAtU48z4XW4mlvd4p9jTp/fdgzFU6aJ
 OvVmvEgKsCUk6H2SA3bTfYTK18uVnUB/yA64OyCu8leEIdRh4svQSZIX8/U7Ba7n0CDKEeg7gyP
 ZqgclhgVyYFpVBgHmk2Q477nkSAwfVeIz/BprzpY3rmhwTsJZtjt+vgi2J+Elo7DSWwQbzy9UlK
 LF4RCu4OATV7xJrjIFXLIToGo357VJXeLBkovwoIg1SZ5j0xJ8yPtVYyKqocKtUFC3BZrgCip9i
 r6ni7hBbLqKwHD/gav49MKz3gLHG32nvGZZ8psIiP4VlfQLbg4TL78sttNe4Oo9TU6fLeLoZxYn
 A7z7W5oYegPwDVMMtzxgp+Q50oK03MJoP5YL4xzycM4pLqadr3sWfbyd3Pyin3g9lAr8kNRF8ta
 oh+hHjcpet5zv9FPDM9gsY
X-Received: by 2002:a05:701b:4348:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1ac5c369c74mr4992759c88.13.1793398132023; 
 Fri, 30 Oct 2026 15:08:52 -0700 (PDT)
X-Received: by 2002:a05:701b:4348:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1ac5c369c74mr4992741c88.13.1793398131527; 
 Fri, 30 Oct 2026 15:08:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm9965691eec.19.2026.10.30.15.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:08:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 5/8] target/hexagon: gate HMX exec on SSR:XE2
Date: Fri, 30 Oct 2026 15:08:37 -0700
Message-Id: <20261030220840.4142885-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
References: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: ut0FEL5Auy3WVponT3swp33IJG_Hy2JH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX5dfrheZFJzEu
 hz3Vh541FDpFwt7UDBIXKbyTZQysxNlS0sTZV2U42HgABLv02nHC8RSgpMd7OV7esNbUqhItiEz
 auFQglQ3fs6Wymxvs1UBI8hVEw2s496NQe4p/Is6GAjiQ/NP+/8qJQ7FJgZ6/xJTuQebFjDq5C7
 HfXHc8VeU5hc1LJ9Wuq5J8v4PEY+Bh8Z02haMQMYtlRtLz2ChGdpX7trr25oYz0yK8y4G7ixC7g
 hRtC7W3FkH6ymw1+6+NqTPB95F/C+EeAveTw3oYDnkE6N7eTgEJNnRr0S6X15o83gHnMzn7fk9p
 okK0m2eOTtgJE3ZV4ebSHsX9xdrISiT7RSMiyf6DGqQ9lYfH97qo+P1oqBkpBHB2qAHModYqphU
 bMmqN19KfftPjsxSGiyBSMV+koO/i5X9vgydvKUt5l2i/Yb9ej29V8Q8ZPbRV2v1BhCojOLNfsT
 EOACLdRjH2j5qfHdoCA==
X-Proofpoint-GUID: ut0FEL5Auy3WVponT3swp33IJG_Hy2JH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX4AKHaN+slWtN
 3VcXDRrUpJMZFpzTPV6LphvyeIJq4+Lt5N05CAJbqi3LRSMxtB2XC4ArLIkUkLnqSUKdaS0aP/l
 ls4WhIeeUZKS1FKbz6+2JKN21k8P4VU=
X-Authority-Analysis: v=2.4 cv=FvOQbGrq c=1 sm=1 tr=0 ts=6ae51574 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OCf9wL_4i7BUJax0SAUA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088
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

RXhlY3V0aW5nIGFuIEhNWCBpbnN0cnVjdGlvbiB3aXRoIFNTUjpYRTIgY2xlYXIgcmFpc2VzIGEg
Tk9fQ09QUk9DMl9FTkFCTEUKZXhjZXB0aW9uLgoKTG9nIHBhY2tldHMgb25lIGFzIExPR19VTklN
UCBmb3Igbm93LgoKUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5x
dWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAg
ICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2luc24uaCAgICAgICAgICAgICAgICAgICAgIHwgIDEg
KwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgICAgfCAgMiArKwogdGFy
Z2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMyArKysKIHRhcmdldC9o
ZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAgICAgICAgIHwgIDMgKysrCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICB8IDIxICsrKysrKysrKysrKysrKysrKysrKwog
dGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgfCAgMyArKysKIDcgZmls
ZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggMjJhYTE2MzA3NjcuLjFjZGZmNTgz
ZGE0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdv
bi9jcHUuaApAQCAtMjQ3LDYgKzI0Nyw3IEBAIEZJRUxEKFRCX0ZMQUdTLCBNTVVfSU5ERVgsIDEs
IDMpCiBGSUVMRChUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVELCA1LCAxKQogRklFTEQoVEJf
RkxBR1MsIENQVV9NT0RFLCA2LCAyKQogRklFTEQoVEJfRkxBR1MsIFNTX0FDVElWRSwgOCwgMSkK
K0ZJRUxEKFRCX0ZMQUdTLCBITVhfQ09QUk9DX0VOQUJMRUQsIDE1LCAxKQogCiBHX05PUkVUVVJO
IHZvaWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNl
cHRpb24sCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9pbnNuLmggYi90YXJnZXQvaGV4YWdv
bi9pbnNuLmgKaW5kZXggNWQ1OTQzMGRhOWUuLmFmYWU5MjhlNjc5IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9pbnNuLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaW5zbi5oCkBAIC03MCw2ICs3
MCw3IEBAIHN0cnVjdCBQYWNrZXQgewogICAgIGJvb2wgcGt0X2hhc19zY2FsYXJfc3RvcmVfczE7
CiAKICAgICBib29sIHBrdF9oYXNfaHZ4OworICAgIGJvb2wgcGt0X2hhc19obXg7CiAgICAgSW5z
biAqdmhpc3RfaW5zbjsKIAogICAgIEluc24gaW5zbltJTlNUUlVDVElPTlNfTUFYXTsKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNs
YXRlLmgKaW5kZXggYmM1ZjIwMjE2M2YuLjg4Yjk0OGU4NjY5IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAt
MTAxLDYgKzEwMSw4IEBAIHR5cGVkZWYgc3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIGh2eF9jb3Byb2NfZW5hYmxlZDsKICAgICBib29sIGh2eF9j
aGVja19lbWl0dGVkOworICAgIGJvb2wgaG14X2NvcHJvY19lbmFibGVkOworICAgIGJvb2wgaG14
X2NoZWNrX2VtaXR0ZWQ7CiB9IERpc2FzQ29udGV4dDsKIAogYm9vbCBpc19nYXRoZXJfc3RvcmVf
aW5zbihEaXNhc0NvbnRleHQgKmN0eCk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUu
YyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDgzZTIzNzc1ZWEyLi4zNDM0YmM4ZmRiMiAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1
LmMKQEAgLTM5Myw2ICszOTMsOSBAQCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhhZ29uX2dldF90
Yl9jcHVfc3RhdGUoQ1BVU3RhdGUgKmNzKQogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIoaGV4
X2ZsYWdzLCBUQl9GTEFHUywgU1NfQUNUSVZFLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
R0VUX1NTUl9GSUVMRChTU1JfU1MsIGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl0pICYmCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBnZXRfY3B1X21vZGUoZW52KSAhPSBIRVhfQ1BVX01PREVf
TU9OSVRPUik7CisgICAgaGV4X2ZsYWdzID0gRklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdT
LCBITVhfQ09QUk9DX0VOQUJMRUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBjcHUtPmht
eCAmJgorICAgICAgICAgICAgICAgICAgICAgICAgICAgR0VUX1NTUl9GSUVMRChTU1JfWEUyLCBl
bnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdKSk7CiAjZWxzZQogICAgIGhleF9mbGFncyA9IEZJRUxE
X0RQMzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLCBNTVVfVVNFUl9JRFgpOwogI2Vu
ZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29u
L2RlY29kZS5jCmluZGV4IDBhYzg3YmJlZTBjLi4yOTE2ZTRjNjhkZiAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKQEAgLTc3
Myw5ICs3NzMsMTIgQEAgaW50IGRlY29kZV9wYWNrZXQoRGlzYXNDb250ZXh0ICpjdHgsIGludCBt
YXhfd29yZHMsIGNvbnN0IHVpbnQzMl90ICp3b3JkcywKIAogICAgIHBrdC0+ZW5jb2RfcGt0X3Np
emVfaW5fYnl0ZXMgPSB3b3Jkc19yZWFkICogNDsKICAgICBwa3QtPnBrdF9oYXNfaHZ4ID0gZmFs
c2U7CisgICAgcGt0LT5wa3RfaGFzX2hteCA9IGZhbHNlOwogICAgIGZvciAoaSA9IDA7IGkgPCBu
dW1faW5zbnM7IGkrKykgewogICAgICAgICBwa3QtPnBrdF9oYXNfaHZ4IHw9CiAgICAgICAgICAg
ICBHRVRfQVRUUklCKHBrdC0+aW5zbltpXS5vcGNvZGUsIEFfQ1ZJKTsKKyAgICAgICAgcGt0LT5w
a3RfaGFzX2hteCB8PQorICAgICAgICAgICAgR0VUX0FUVFJJQihwa3QtPmluc25baV0ub3Bjb2Rl
LCBBX0hNWCk7CiAgICAgfQogCiAgICAgLyoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggOTE5MjVkMmRkYjEu
LjRjODRmZWFlZWI1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtODYwLDYgKzg2MCwyNCBAQCBzdGF0aWMg
dm9pZCBnZW5fc3RhcnRfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPmh2
eF9jaGVja19lbWl0dGVkID0gdHJ1ZTsKICAgICB9CiAjZW5kaWYKKworICAgIGlmIChjdHgtPnBr
dC5wa3RfaGFzX2hteCkgeworICAgICAgICBmb3IgKGkgPSAwOyBpIDwgY3R4LT5wa3QubnVtX2lu
c25zOyBpKyspIHsKKyAgICAgICAgICAgIGlmIChHRVRfQVRUUklCKGN0eC0+cGt0Lmluc25baV0u
b3Bjb2RlLCBBX0hNWCkpIHsKKyAgICAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19VTklN
UCwgIiclcycgaXMgbm90IGltcGxlbWVudGVkXG4iLAorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgb3Bjb2RlX25hbWVzW2N0eC0+cGt0Lmluc25baV0ub3Bjb2RlXSk7CisgICAgICAgICAg
ICB9CisgICAgICAgIH0KKyAgICB9CisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIC8q
IEhNWCBuZWVkcyBTU1I6WEUyICovCisgICAgaWYgKGN0eC0+cGt0LnBrdF9oYXNfaG14ICYmICFj
dHgtPmhteF9jb3Byb2NfZW5hYmxlZCAmJgorICAgICAgICAhY3R4LT5obXhfY2hlY2tfZW1pdHRl
ZCkgeworICAgICAgICBnZW5fcHJlY2lzZV9leGNlcHRpb24oSEVYX0NBVVNFX05PX0NPUFJPQzJf
RU5BQkxFLCBjdHgtPnBrdC5wYyk7CisgICAgICAgIGN0eC0+aG14X2NoZWNrX2VtaXR0ZWQgPSB0
cnVlOworICAgIH0KKyNlbmRpZgogfQogCiBib29sIGlzX2dhdGhlcl9zdG9yZV9pbnNuKERpc2Fz
Q29udGV4dCAqY3R4KQpAQCAtMTQzNCw2ICsxNDUyLDkgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl90
cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlzYXNDb250ZXh0QmFzZSAqZGNiYXNlLAogICAgICAgICBj
dHgtPmJhc2UubWF4X2luc25zID0gMTsKICAgICAgICAgY3R4LT5pc190aWdodF9sb29wID0gZmFs
c2U7CiAgICAgfQorICAgIGN0eC0+aG14X2NvcHJvY19lbmFibGVkID0KKyAgICAgICAgRklFTERf
RVgzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBITVhfQ09QUk9DX0VOQUJMRUQpOworICAgIGN0eC0+
aG14X2NoZWNrX2VtaXR0ZWQgPSBmYWxzZTsKICNlbmRpZgogfQogCmRpZmYgLS1naXQgYS90ZXN0
cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwv
aGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IDFjMWQ1NDQwYmI2Li5kM2Y5Yjk1ZDk2MSAx
MDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKKysr
IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTkwLDYgKzkw
LDkgQEAgZGVmIHRlc3RfYWNjZXNzKHNlbGYpOgogICAgIGRlZiB0ZXN0X3NlbWlob3N0KHNlbGYp
OgogICAgICAgICBzZWxmLnJ1bl9jb25zb2xlX3BhdHRlcm4oInNlbWlob3N0IiwgIlBBU1MiLCAi
LWFwcGVuZCIsICJhcmcxIiwgImFyZzIiKQogCisgICAgZGVmIHRlc3RfaW52YWxpZF9obXgoc2Vs
Zik6CisgICAgICAgIHNlbGYucnVuX2V4aXRfemVybygiaW52YWxpZF9obXgiKQorCiAgICAgZGVm
IHRlc3RfZHRnX2ludGVycnVwdChzZWxmKToKICAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJk
dGdfaW50ZXJydXB0IikKIAotLSAKMi4zNC4xCgo=

