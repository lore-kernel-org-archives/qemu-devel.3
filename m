Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C1C606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ATkAuTzf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AYG0Wclc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMD3J-0003uF-4z; Wed, 28 Oct 2026 19:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMD3H-0003tj-Bt
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:27:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMD3F-0003zW-Vf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:27:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMA3QM2369036
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=McvJ80p72Fa0uNMHY/sXM4
 NRa49xRMRTXReHj5sFU78=; b=ATkAuTzfTI2WbzLxojVMV27cdasm1DB5rQF2Gs
 n0BekkMsoKZC9YQLhknbXM6YCtU0eABM/bqxIdJ+svI+xtiCm0RfDI80ZCCJEeUw
 8KLqGuuCunAXNO82GKLO0gMjra3dANW1F4yvlGBDzkCuZHpzMsyLXATdFPqiG1HO
 pLuGjKNatH4gkEYZ1Wq3xt57Yb3NUT54B26G8rSwYVKqRaukSo+p2+VPPljEnnRn
 epPWCn1dDgDunL+IcefvpI3O0cYIR/uAAHWSkFMfUNaO0CXHYXLY1lSO+Kf6RF+c
 Ar2ajGK6jnaJNyUgMTHuC9QLe7V65zQiq43tHOirKe/SChrQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgprxr3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:27:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3662e7a9299so5974006eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 16:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793230042; x=1793834842; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=McvJ80p72Fa0uNMHY/sXM4NRa49xRMRTXReHj5sFU78=;
 b=AYG0WclcUogQ81z83odeRoSF8QgxAgtxiuD0df62953zNYj/S8W3ABUpU/QNKNB1nu
 dmMDWt0aiJ02dLlVpW40uYmUttIpNU+gHskHDK2rzgVryBdXM03ullup5TjwPu+YA4gp
 OWrtxKdNywudVVk2RHdp2Qs43fR/vrmONFIV0HAHYXL6dCDoMiYg5kUw4aAt23lFljPA
 siyiP47TYNRRFGA5ae3qX/vs/07zC0XTIzYZeHn/TWOiAeHGaQEQTnDbiYktKTQMNHmF
 cExl5/dGK/i3RM2Adl6JK0M6Ra6EdldDGKX2ifZys2ng8c5oF0BwcEycEa8+nSAYr2uw
 zM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793230042; x=1793834842;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=McvJ80p72Fa0uNMHY/sXM4NRa49xRMRTXReHj5sFU78=;
 b=uxqkatiHlvgkeIdxzgUyzeghLkoaGefkSDcClBGY8hmVDUMo8yqCqoll8v1q9jold/
 cZStGlENytQt3Q8QbEhszXuYkiq7WtU/SCMrsRdREPnG8TlgpFEUU5hW0ZrHDvOJ53/m
 tJoeHtDZaONS3iZl+QbYxyVh9nT/rlwOu/DQIpXiQXciR9vMTO2ZKF1Wn1VuGU2wabva
 J0FfTW4LL8Oi+j9d37DYttdHeJBCn++sD4ELpVSDuyAXCssQM6gkmj+npmLWyctHYrZ8
 Se1GngkY/Jk2t1KDezKBNgxciJAXwOc8vMk3zjAHnRgEvy3BLBoB5uAdKy1pQNuwUaw0
 JgVg==
X-Gm-Message-State: AFq9FYJSkOfUh7E9O50BDEU8dRE/LmlP65202Q62btOflSC4+Bp5CHQt
 Dv7NY2LRUmwBS78KsyFVTQsfn0YOufLAo4a4Z+mcu+ljtVSCAbjk6aeDL2KLe5pIJ2pNGiF4S+r
 IMGUaQ2ZTnQGKkjauw5zzcXhUKq/AzO+ABhfXeY6oWni8Z8qCI+ZPjEG/f5CDDQzOPQ==
X-Gm-Gg: AYBFou0712OnDxsXqsjWMyoqFkObCJHID9eWqpNbO+oAfOYj9atj6NydCqI2ICbMLW8
 ai5I1cnUWUlVoyYoids9RJazWJkBkn1SaE11lG1gWLVPkP6hWvQRAckW4XcR7UDkFBM8KKwNhBf
 R7e4t6jpCMQMSy8Rn0Aui1H1Ic21GOfNIXH7X1pKIkbBFXB7qiRV98B3n9fSrQ9S9ThC8TcFxKy
 W+sjbVc+ENm6mPknoxVsH2B4eWKOTxJqlB1bJlHFTWiNmOZNC1P3SSAE1rYL0uu1rO8JHgZloCI
 oPgVbtQqhocDh5+nv0FpI0O5d4SoOz2UVHcbBq6f0+6BgpYgkHe0AMu0DyNMbRRl1g7uO4y6KKT
 eXriWr8fMgA8L4O8RGUEr256yqSIeSR/O281idcJRlvD3ZB6o1MHV4nXOKTU8KTRW2N3STjptAT
 aox9bbslWUe3ZfV29USC+Yrw==
X-Received: by 2002:a05:7300:f28f:b0:36a:119d:a099 with SMTP id
 5a478bee46e88-36a202bc3bfmr5300463eec.5.1793230042196; 
 Wed, 28 Oct 2026 16:27:22 -0700 (PDT)
X-Received: by 2002:a05:7300:f28f:b0:36a:119d:a099 with SMTP id
 5a478bee46e88-36a202bc3bfmr5300444eec.5.1793230041614; 
 Wed, 28 Oct 2026 16:27:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a238da3e1sm14020827eec.8.2026.10.28.16.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 16:27:21 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/1] Hexagon: add FP exception
Date: Wed, 28 Oct 2026 16:27:19 -0700
Message-Id: <20261028232720.3331505-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA5MyBTYWx0ZWRfX3gewWGk4nMcG
 G3M7yS9TXtGB2MdxVmpd+QZkkh/MjjrysR2tm7518Az8zzu3Mwn/Ycrwh+fHPGkZPoKCHkzKhis
 rFZJW3sZvYx+tp1adTtLS2YebMkR9QGAL3RbiZAACaUYSQ1rlkzBw9NrcyXOMoxMhtGeKv1Anu6
 PIeu4XeopCA7+8+Gf8wQx67IQtIkXqoNfiz08b3CxUT9A3/j3+M8E3X+XVBmuOitBf8RyGTViEg
 vlXgJ8zXnVWxLXuBBFvzDwt7XldwOeyFBILFgA8yENL/TgfxvKggJ66xTBmnpw6NJu49zM39mYl
 iZEaMEUgi1c0A7GQ1/hq+fmELfUxNOD7shVpPN3NL4ylkPX4gU/lLijbuDl5YBp8mqIRS2vDbTe
 omFJJmYdc1wUkJQge/FOdsr9UiMIK4e3K+fDp6GGiphTniCwJqPGgyluPDZ8Z+ABax5scItsuOE
 dsylKanSTtxHG1RsMjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA5MyBTYWx0ZWRfX/JlsXgLuJN9O
 poGOJkgwRxGMVbaguvVpZHsX95RLSIDLF7X0yJ82idksk7uZNTUidV8RQdPCPYgkN0w2PsB9vM1
 0cMwW0UGjt9Jn8AvkcOolnuzI/C/eNQ=
X-Proofpoint-ORIG-GUID: BGgJq751i83-gx_8Z-Ow0Uth5XOI0JNe
X-Proofpoint-GUID: BGgJq751i83-gx_8Z-Ow0Uth5XOI0JNe
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae284db cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=vPTgGUCOOlAyRlJmxaUA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIGZsb2F0aW5nLXBvaW50IGV4Y2VwdGlvbiB3YXMgbGVmdCBhcyBhbiB1bmltcGxlbWVudGVk
IHN0dWIsIHRoaXMKY29tbWl0IGZpbGxzIGl0IGluLgoKQnJpYW4gQ2FpbiAoMSk6CiAgdGFyZ2V0
L2hleGFnb246IGltcGxlbWVudCBmbG9hdGluZy1wb2ludCBleGNlcHRpb24gZm9yIHN5c2VtdQoK
IHRhcmdldC9oZXhhZ29uL2FyY2guYyB8IDEzICsrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

