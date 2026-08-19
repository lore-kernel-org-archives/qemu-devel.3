Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489E5C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwVA2-0008Mi-Hl; Tue, 18 Aug 2026 21:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwVA0-0008MG-BD
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9y-0008E0-DH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:08 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkWOx2775482
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fjl8aKGT0z4dIjKw/fwlqubDkiypCjE9DRkAgvVKwV8=; b=jJCQi7jYloOeqVN8
 GAC8XDHKvfIaD0wkLG216nxBCzLj6ILrYgdFuVFF8R21mRdX0Lf6ZMpHU6IVQBrr
 pgoYmdmZNWos5d/EJJVCdBPT30/cNeZ0UTPzJSpp7KKzWOLl5xNXWoMDVpoCkP3m
 mNaH6tEsIX0UsOSlcTbCtIPvA5uLsuWg+k4ng1bKRW5UN4xOmqvtezKDGcTBYqQT
 nB6C0df0fIO/8Wheb281Hn2bTCGGhN4i4IUSlgfXcCd8WMCvf+QEppUNOCpMe13N
 Nm49AFJ6B/e4KGdXkuUXxNgo/mpLQ+gzEko/9JDf/ZbiPDw3hLs75BIc88Avp0j+
 bO4NLQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yftrr1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:32:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso316774a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103124; x=1787707924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fjl8aKGT0z4dIjKw/fwlqubDkiypCjE9DRkAgvVKwV8=;
 b=dj/H1XO2W1DWIjCgMPQ6PgsvMhKOctYKztD24egTW42vp+1HqKpMOcOGDwU6pc2VAi
 /yeue0GP/b7PSyVjJ36/cUBtL0zM2sy4+CAL14AFN9BGex02bV7PE1MNkSmMbeVhYpAT
 y63iN6tkXWxTxnC12ku1OIoWtK2SBMxD8u4xsCJfrV1U3edNN8myB8+bCbtPD8iq9x00
 /tp9PwLSkQuQpnojBcNNsPVm5BrkdWgAcoe38RUeDjHkj9eAwChT3CRPR1sx820gStLG
 bBcWzPaAWrqKQaMkHPu7jPU/ri5oHNYyOnpvfFXo4lmqeN5XdexDInTrYveKV1Tz8VaL
 yPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103124; x=1787707924;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fjl8aKGT0z4dIjKw/fwlqubDkiypCjE9DRkAgvVKwV8=;
 b=VUFPvoU2zzvua7CUDwmcLxZ5AXWI+29YXUZ2Jo+/Rp2a6wMhv3WgqP/iDXJZpGOUH5
 xcBNjwDQMdEK29T/V9M4tGfuotO6QifDef/ZhTfcqUrnzW7N+TYeh1gbaujSqhZE3Zom
 tXx+00IbqVwVxbKJ2p61jMUglVE6fHDlQRQjTxC7FeOoE7DXoVTWvPtWcgEa/U9+n309
 zW4XuLp13kypeFsPklAVBG1SAjqiOq7OniqX3FLKWzOliQM0rXH4r+NWwgXkIqgnRiqK
 /jsb6VZ5pkUQKg/XaLh774o81tEsP5IL24kFUIFg8Mu1kcePz3vUCLIEzugFo1x+P/XR
 Crxw==
X-Gm-Message-State: AOJu0Yxwtg9taRVFTqADpI9DAgHRz1OifMu+0W9aR9SEX5MhKXSVUUF+
 bBPQ5/7+PmojIRHzHWCtPVCnBYHQE058LiFlMBpBSotmukixFEZWXq41gw7qdqACMKytvc2kaRO
 f2IRcR98FJO615ezDn2tRlItLFf3QYnwi7Tl1O0FF3pWhEIdyZd1IFkzVJfg5/eBG4Q==
X-Gm-Gg: AR+sD11kkVdMvXuj2/kLuTHHClqg+44pmqrBszbn0zwaWkifBE6w0EQVieWBYC1+YWS
 MdJ9+dvh4UZyqTw3uy5JHotPLNP6COM3rCsiK2GxYB4XTFwhTqHJP5HPuG5dDxZvUlaEYx4jprx
 CtOpOj9IcFJi8kjZ+EtclD+P8k0xGIpa6byoxJ0fJnLJXhwRk/L9TcGLr8rnOR4IsBLvvPG3fCr
 p8nJ0y0dTrp7O0o2qKnLD++ucvuOox3DeHMO+43VgdGfFnV0GzMAfVMCnNsD4ckOOKg/e+iOyEk
 m58cFgqkgyegVGlR+XSLQ/vYLwxDLpXgFVmXOunW+r677E4v75Nk3lSh/EuEc72PFX50/ijrCjm
 tPM7eMMFeSN+cAWPh2YOaNTIjsPVr5HycliRIuFjH7IOV+RPX
X-Received: by 2002:a05:6a20:6f87:b0:3c3:7762:5d5f with SMTP id
 adf61e73a8af0-3cd01322a9fmr2330138637.19.1787103124179; 
 Tue, 18 Aug 2026 18:32:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f87:b0:3c3:7762:5d5f with SMTP id
 adf61e73a8af0-3cd01322a9fmr2330045637.19.1787103123743; 
 Tue, 18 Aug 2026 18:32:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:32:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 09/11] target/hexagon: implement direct-to-guest interrupt
 delivery
Date: Tue, 18 Aug 2026 18:31:42 -0700
Message-Id: <20260819013144.3264096-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FIorAeos c=1 sm=1 tr=0 ts=6a850795 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Zk8ngpzFGPinGHXTi4kA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfXzioY1mbUVny5
 DAqYNmRZuunZyYEXZaJ8hz7q3vji0WsDbJsN79C8IbUJgJDwQwmIJbvjnBy+F+CYmyh27JHzjet
 rzHruJn1VXhOn4Xj8InBSetPLFFHHC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX3b3PM31Sqx/R
 dbYBnoQ/Y5zOI9qLRNExu5p7tqMD6kOYpZb9aT9nDpuiwqeDffCoBSUbTg9KdqCi46FI6lfyYBR
 qwLiAzqmaAV+AUVkAQBW1giOeTyqp80Ch6Eu+7O6RHsLv/7vOT29fWDIDjYi9+oXXCECgwu34bx
 3gjshBDay/mWFiQdzrdObiXUzd474pAljJLB2AJiX/F+Id8trXYSvnidJKXvB05lELdcnjqbWyv
 eS1apL5Agd3wSiq3bJEpC9+VFMLrTCj39K43gZtp9elK8od3ZKdCn2Tg/MV4hiV43eDZWVlwCfs
 RqIYYizjorQxVyX/C4uGKYp8NMS5vqB7ZYMxRxQPTxtZgy7I3KmijRlpa4YnkiDlZCHakDsbWGc
 o74mPn4l1QAvdg3qDfeqY+y8l2wTp/QUJCtgzBWEAjkI3iEQnEW0heo46KRroyzbo+sOd14PMWC
 cDUGo5Fp7bXf1w0LO/w==
X-Proofpoint-GUID: BMMSi-qpuSTtX6A_FjTOK3KKUcNeF9pu
X-Proofpoint-ORIG-GUID: BMMSi-qpuSTtX6A_FjTOK3KKUcNeF9pu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190009
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

SW50ZXJydXB0cyAzIHRocm91Z2ggNSBhcmUgcm91dGVkIHRvIGd1ZXN0IG1vZGUgd2hlbiBDQ1I6
R0lFIGFuZCB0aGUKbWF0Y2hpbmcgQ0NSOlZWIGJpdCBhcmUgc2V0LiAgRW50ZXIgdGhyb3VnaCBH
RVZCIHJhdGhlciB0aGFuIEVWQiwKcmVjb3JkIHRoZSBwcmUtZW50cnkgc3RhdGUgaW4gR1NSIGFu
ZCB0aGUgcmV0dXJuIGFkZHJlc3MgaW4gR0VMUiwgYW5kCnJlYWQgdGhlIHZlY3RvciBJRCBmcm9t
IHRoZSBsMnZpYy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYyB8ICA3
ICsrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgfCAgNSArKwogdGFyZ2V0
L2hleGFnb24vaGV4X2ludGVycnVwdHMuYyAgICAgfCA4NyArKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3JlZ19maWVsZHNfZGVmLmguaW5jIGIvdGFy
Z2V0L2hleGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMKaW5kZXggZDJjNzA2ZDU2YjUuLjI5NDk3
ZmJjYzRkIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwor
KysgYi90YXJnZXQvaGV4YWdvbi9yZWdfZmllbGRzX2RlZi5oLmluYwpAQCAtMTM2LDYgKzEzNiwx
MyBAQCBERUZfUkVHX0ZJRUxEKENDUl9WVjEsIDI5LCAxKQogREVGX1JFR19GSUVMRChDQ1JfVlYy
LCAzMCwgMSkKIERFRl9SRUdfRklFTEQoQ0NSX1ZWMywgMzEsIDEpCiAKKy8qIEdTUiBmaWVsZHMg
Ki8KK0RFRl9SRUdfRklFTEQoR1NSX0NBVVNFLCAwLCAxNikKK0RFRl9SRUdfRklFTEQoR1NSX0NG
SSwgMjgsIDEpCitERUZfUkVHX0ZJRUxEKEdTUl9TUywgMjksIDEpCitERUZfUkVHX0ZJRUxEKEdT
Ul9JRSwgMzAsIDEpCitERUZfUkVHX0ZJRUxEKEdTUl9VTSwgMzEsIDEpCisKIC8qIElTREIgU1Qg
ZmllbGRzICovCiBERUZfUkVHX0ZJRUxEKElTREJTVF9XQUlUUlVOLCAyNCwgOCkKIERFRl9SRUdf
RklFTEQoSVNEQlNUX09OT0ZGLCAxNiwgOCkKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2Nw
dS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggMGE2Nzc4NDBiY2IuLmVmYWY1NjljNmY4
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9j
cHUuYwpAQCAtNDc1LDYgKzQ3NSwxMSBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZWFsaXpl
KERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiaGV4YWdvbiBjcHUgcmVxdWlyZXMgJ3RsYicgbGluayBwcm9wZXJ0eSB0byBiZSBzZXQiKTsK
ICAgICAgICAgcmV0dXJuOwogICAgIH0KKyAgICBpZiAoIUhFWEFHT05fQ1BVKGRldiktPmwydmlj
KSB7CisgICAgICAgIGVycm9yX3NldGcoZXJycCwKKyAgICAgICAgICAgICAgICAgICAiaGV4YWdv
biBjcHUgcmVxdWlyZXMgJ2wydmljJyBsaW5rIHByb3BlcnR5IHRvIGJlIHNldCIpOworICAgICAg
ICByZXR1cm47CisgICAgfQogI2VuZGlmCiAKICAgICBxZW11X2luaXRfdmNwdShjcyk7CmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfaW50ZXJydXB0cy5jIGIvdGFyZ2V0L2hleGFnb24v
aGV4X2ludGVycnVwdHMuYwppbmRleCAzNTM0NDgxZGEyNC4uZWExYmEwOTAzZGQgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2hleF9pbnRlcnJ1cHRzLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
aGV4X2ludGVycnVwdHMuYwpAQCAtMTEsNiArMTEsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIu
aCIKICNpbmNsdWRlICJleGVjL2NwdS1pbnRlcnJ1cHQuaCIKICNpbmNsdWRlICJoZXhfaW50ZXJy
dXB0cy5oIgorI2luY2x1ZGUgImh3L2ludGMvaGV4LWwydmljLmgiCiAjaW5jbHVkZSAibWFjcm9z
LmgiCiAjaW5jbHVkZSAic3lzX21hY3Jvcy5oIgogI2luY2x1ZGUgInN5c3RlbS9jcHVzLmgiCkBA
IC0yMTUsMTkgKzIxNiw3NSBAQCBzdGF0aWMgdm9pZCByZXN0b3JlX3N0YXRlKENQVUhleGFnb25T
dGF0ZSAqZW52LCBib29sIGludF9hY2NlcHRlZCkKICAgICB9CiB9CiAKK3N0YXRpYyBib29sIGlu
dF9zaG91bGRfZHRnKENQVUhleGFnb25TdGF0ZSAqZW52LCBpbnQgaW50X251bSkKK3sKKyAgICB1
aW50MzJfdCBjY3IgPSBlbnYtPnRfc3JlZ1tIRVhfU1JFR19DQ1JdOworCisgICAgc3dpdGNoIChp
bnRfbnVtKSB7CisgICAgY2FzZSAzOgorICAgICAgICBpZiAoIUdFVF9GSUVMRChDQ1JfVlYxLCBj
Y3IpKSB7CisgICAgICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgICAgIH0KKyAgICAgICAgYnJl
YWs7CisgICAgY2FzZSA0OgorICAgICAgICBpZiAoIUdFVF9GSUVMRChDQ1JfVlYyLCBjY3IpKSB7
CisgICAgICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgICAgIH0KKyAgICAgICAgYnJlYWs7Cisg
ICAgY2FzZSA1OgorICAgICAgICBpZiAoIUdFVF9GSUVMRChDQ1JfVlYzLCBjY3IpKSB7CisgICAg
ICAgICAgICByZXR1cm4gZmFsc2U7CisgICAgICAgIH0KKyAgICAgICAgYnJlYWs7CisgICAgZGVm
YXVsdDoKKyAgICAgICAgcmV0dXJuIGZhbHNlOworICAgIH0KKworICAgIHJldHVybiBHRVRfRklF
TEQoQ0NSX0dJRSwgY2NyKTsKK30KKworc3RhdGljIHZvaWQgZ3Vlc3RfaW50ZXJydXB0X2VudHJ5
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVzZSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1aW50MzJfdCBldmVudF9wYykKK3sKKyAgICB1aW50MzJfdCBvbGRf
c3NyID0gZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXTsKKyAgICB1aW50MzJfdCBuZXdfc3NyID0g
b2xkX3NzcjsKKyAgICB1aW50MzJfdCBjY3IgPSBlbnYtPnRfc3JlZ1tIRVhfU1JFR19DQ1JdOwor
ICAgIHVpbnQzMl90IGdzciA9IDA7CisKKyAgICBnc3IgPSBkZXBvc2l0MzIoZ3NyLCByZWdfZmll
bGRfaW5mb1tHU1JfQ0FVU0VdLm9mZnNldCwKKyAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxk
X2luZm9bR1NSX0NBVVNFXS53aWR0aCwgY2F1c2UpOworICAgIGdzciA9IGRlcG9zaXQzMihnc3Is
IHJlZ19maWVsZF9pbmZvW0dTUl9TU10ub2Zmc2V0LAorICAgICAgICAgICAgICAgICAgICByZWdf
ZmllbGRfaW5mb1tHU1JfU1NdLndpZHRoLAorICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJ
RUxEKFNTUl9TUywgb2xkX3NzcikpOworICAgIGdzciA9IGRlcG9zaXQzMihnc3IsIHJlZ19maWVs
ZF9pbmZvW0dTUl9VTV0ub2Zmc2V0LAorICAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5m
b1tHU1JfVU1dLndpZHRoLAorICAgICAgICAgICAgICAgICAgICAhR0VUX1NTUl9GSUVMRChTU1Jf
R00sIG9sZF9zc3IpKTsKKyAgICBnc3IgPSBkZXBvc2l0MzIoZ3NyLCByZWdfZmllbGRfaW5mb1tH
U1JfSUVdLm9mZnNldCwKKyAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bR1NSX0lF
XS53aWR0aCwKKyAgICAgICAgICAgICAgICAgICAgR0VUX0ZJRUxEKENDUl9HSUUsIGNjcikpOwor
ICAgIGVudi0+Z3JlZ1tIRVhfR1JFR19HU1JdID0gZ3NyOworCisgICAgZlNFVF9GSUVMRChuZXdf
c3NyLCBTU1JfU1MsIDApOworICAgIGZTRVRfRklFTEQobmV3X3NzciwgU1NSX0dNLCAxKTsKKyAg
ICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19TU1JdID0gbmV3X3NzcjsKKyAgICBoZXhhZ29uX21vZGlm
eV9zc3IoZW52LCBuZXdfc3NyLCBvbGRfc3NyKTsKKworICAgIFNFVF9TWVNURU1fRklFTEQoZW52
LCBIRVhfU1JFR19DQ1IsIENDUl9HSUUsIDApOworICAgIGVudi0+Z3JlZ1tIRVhfR1JFR19HRUxS
XSA9IGV2ZW50X3BjOworICAgIGVudi0+Z3ByW0hFWF9SRUdfUENdID0gZW52LT50X3NyZWdbSEVY
X1NSRUdfR0VWQl0gfAorICAgICAgICAgICAgICAgICAgICAgICAgICAgKEhFWF9FVkVOVF9JTlQw
IDw8IDIpOworfQorCiBzdGF0aWMgdm9pZCBoZXhfYWNjZXB0X2ludChDUFVIZXhhZ29uU3RhdGUg
KmVudiwgaW50IGludF9udW0pCiB7CiAgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOwog
ICAgIEhleGFnb25DUFUgKmNwdSA9IGVudl9hcmNoY3B1KGVudik7Ci0gICAgdWludDMyX3QgZXZi
ID0KLSAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9T
UkVHX0VWQiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKTsK
ICAgICBjb25zdCBpbnQgZXhlX21vZGUgPSBnZXRfZXhlX21vZGUoZW52KTsKICAgICBjb25zdCBi
b29sIGluX3dhaXRfbW9kZSA9IGV4ZV9tb2RlID09IEhFWF9FWEVfTU9ERV9XQUlUOworICAgIHVp
bnQzMl90IGVscjsKIAogICAgIHNldF9pcGVuZF9iaXQoZW52LCBpbnRfbnVtLCAwKTsKICAgICBz
ZXRfaWFkX2JpdChlbnYsIGludF9udW0sIDEpOwotICAgIHNldF9zc3JfZXhfY2F1c2UoZW52LCAx
LCBIRVhfQ0FVU0VfSU5UMCB8IGludF9udW0pOwogICAgIGNzLT5leGNlcHRpb25faW5kZXggPSBI
RVhfRVZFTlRfSU5UMCArIGludF9udW07CiAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0VWRU5U
X0lOVDAgKyBpbnRfbnVtOwogICAgIGNsZWFyX3BlbmRpbmdfbG9ja3MoZW52KTsKQEAgLTIzNSwx
NSArMjkyLDMxIEBAIHN0YXRpYyB2b2lkIGhleF9hY2NlcHRfaW50KENQVUhleGFnb25TdGF0ZSAq
ZW52LCBpbnQgaW50X251bSkKICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwKICAg
ICAgICAgICAgICIlczogdGhyZWFkICIgVEFSR0VUX0ZNVF9sZCAiIHJlc3VtaW5nLCBleGl0aW5n
IFdBSVQgbW9kZVxuIiwKICAgICAgICAgICAgIF9fZnVuY19fLCBlbnYtPnRocmVhZElkKTsKLSAg
ICAgICAgc2V0X2VscihlbnYsIGVudi0+d2FpdF9uZXh0X3BjKTsKKyAgICAgICAgZWxyID0gZW52
LT53YWl0X25leHRfcGM7CiAgICAgICAgIGNsZWFyX3dhaXRfbW9kZShlbnYpOwogICAgICAgICBj
cy0+aGFsdGVkID0gZmFsc2U7CiAgICAgfSBlbHNlIGlmIChlbnYtPmswX2xvY2tfc3RhdGUgPT0g
SEVYX0xPQ0tfV0FJVElORykgewogICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogICAg
IH0gZWxzZSB7Ci0gICAgICAgIHNldF9lbHIoZW52LCBlbnYtPmdwcltIRVhfUkVHX1BDXSk7Cisg
ICAgICAgIGVsciA9IGVudi0+Z3ByW0hFWF9SRUdfUENdOworICAgIH0KKworICAgIGlmIChpbnRf
c2hvdWxkX2R0ZyhlbnYsIGludF9udW0pKSB7CisgICAgICAgIGludCB2aWNfZ3JvdXAgPSBpbnRf
bnVtIC0gMjsKKyAgICAgICAgdWludDMyX3QgdmlkX3BhY2tlZCA9IGwydmljX3JlYWRfdmlkKGNw
dS0+bDJ2aWMsIHZpY19ncm91cCAvIDIpOworICAgICAgICB1aW50MzJfdCB2aWQgPSBleHRyYWN0
MzIodmlkX3BhY2tlZCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh2aWNfZ3Jv
dXAgJiAxKSA/IDE2IDogMCwgMTYpOworCisgICAgICAgIGd1ZXN0X2ludGVycnVwdF9lbnRyeShl
bnYsIHZpZCwgZWxyKTsKKyAgICB9IGVsc2UgeworICAgICAgICB1aW50MzJfdCBldmIgPQorICAg
ICAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVH
X0VWQiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7
CisKKyAgICAgICAgc2V0X3Nzcl9leF9jYXVzZShlbnYsIDEsIEhFWF9DQVVTRV9JTlQwIHwgaW50
X251bSk7CisgICAgICAgIHNldF9lbHIoZW52LCBlbHIpOworICAgICAgICBlbnYtPmdwcltIRVhf
UkVHX1BDXSA9IGV2YiB8IChjcy0+ZXhjZXB0aW9uX2luZGV4IDw8IDIpOwogICAgIH0KLSAgICBl
bnYtPmdwcltIRVhfUkVHX1BDXSA9IGV2YiB8IChjcy0+ZXhjZXB0aW9uX2luZGV4IDw8IDIpOwog
ICAgIGlmIChnZXRfaXBlbmQoZW52KSA9PSAwKSB7CiAgICAgICAgIHJlc3RvcmVfc3RhdGUoZW52
LCB0cnVlKTsKICAgICB9Ci0tIAoyLjM0LjEKCg==

