Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F231AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we399-0001Y2-Ol; Sun, 28 Jun 2026 23:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we393-0001Ve-07
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we38x-0006B5-J5
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2dCPc1550561
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5BKERPusdCznfStdSCYDfdVIL/vKWWKPSQ+gj4UQjS8=; b=NxiRdc1KQmltgOLB
 zAcvLf0F715qqecpKyEP/y3woWGpIN6kXfVkGg/gJCUjfQKhxekYtv9Xj/+ddlu4
 61PuJIwl4J4u/nm3c8nSArcBT71F8ToB0BM8+VvxK2r/6eUj8PJqrqJvf97o3U4J
 60GZ8kiJe3l9EIsH7UNODlwwy154PZYfC8981i4DvJIxfL9iEYTdO1plYS7kSdzz
 RUuPBMvDCO8uik3GOhezt9XgaerENXbNaD+AFkGm6Mba273gOt1Dv/RP/nbAbVJa
 VvT6Vhzms8qUGrqa3cMGeQCMYKQUXsXVAhM0ye6wxWME6KJiWQDPSsezGr04eX03
 WahvVw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mdqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:45 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139f02b1fbeso7529547c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705524; x=1783310324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BKERPusdCznfStdSCYDfdVIL/vKWWKPSQ+gj4UQjS8=;
 b=CAN8jYIWpiIOBmpVHMyHV/PrRSFP6vk/h6wYnfoAXArZAwo9mIybyNzLaNLo6mA5Bb
 pwmoWv2ocJBP4N8wkVXeqaRK0ZVst6sdo0egQOy2FtT31URxQ7IKG/dfWS08EQYab76x
 P816NwCivYBXpDlOkizIOogyXkFmsreLXpxoZr80bbukaU1KNOYxK2tmXKlw/j1V/Ir/
 aw4zdR1Zhn462NzNb3+YZAb84UYi/C8ATgI6uMlUmKG0nMBeWjAjpY1ObQb+S+rswh0X
 6RV8XlSqg/Jo15gl/rTb0J8V+cTBJH2YhgeFzk4OIBjBvCQagYQCZUIrcRe9dI9In9WY
 RFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705524; x=1783310324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5BKERPusdCznfStdSCYDfdVIL/vKWWKPSQ+gj4UQjS8=;
 b=g7ioRNNYL1OohmjnGgEpZ+dBGI5LyAfZZe1lMiikPoRRCvKM62M12HOOYtCcAkGz70
 2csVCicwUqceKm+8Y+CeryaxeWVCHvttiKpGHat/6CISkTB7XRG2A8VNNVk5cqadkxNY
 od299lwS02vcC72peNPyMJk1n5wE1pDqaFtjhPdQlpdp8d5FHgz7cPt63mc4irmVnbRp
 FL5xsxC2PoSgjAjsQZsNPMuSnnJuYTmRFKOM/ZfUQDN+9pBYpckCKqXm+P7yY51dC/Qd
 47hiO7HukMqIbcGFIQc0ArNXQU4mJCiUgL4NrcfL1GcF/7sOFOh2f0Vzo3ERjhfs+wWS
 tzNA==
X-Gm-Message-State: AOJu0YxTkO1/329udBJxpuZLKmbxiMfdolbO712x4wKOgRxXuY0Jx6Um
 oirGA/mgYllCjTiITlEg2hJDmX5ApWE+6rHIRfUgC5/qUZ8EI/WxtXwOi7eRWnzlfnyKf/hAUX0
 IESuXTeeMBfMABSYq4ir3G/YQf65XLImkezMpNtr70ZnJ3EflMd8aI/N6Xg/xFD85mQ==
X-Gm-Gg: AfdE7cl8y5/xzrHUVICcXKO5efaUTAfudlZZfqk57jSiimfOfxZm9Xuoj/98ry4DXlQ
 4N9VWKTW9VXF5lxKF7sK+OAXZ2iCUenKBPB8O0q91ug7fsTqeO/c//C3Tkgoeu34yr97ZDXsUKI
 vv5uYlgO6xXWI/Iku3OKav2Rm3W7sAKhXwR5XYyentrqYojgZsU7GmRgJq+s5hqou50H6iZTM66
 kuAag7tEWWReSRX0Wo/T+WV2dU81W4AqX+tiqoIWdXGvp2tF6WVDBwM1vWDNC/GA2MUhabKy5l9
 9NTHt+Z+PZDjspoSwAqt2lWAM4s4hV/KDr0eYwlnOOAI654bSB1EQHH+nfJ0yC8CEMWAuH0oDhm
 Ta1J6E2xKrg72xydRNHNCTgVMOQm6rJ3TwbXH/E+s/i+XMJYRhdcTyik6c5c=
X-Received: by 2002:a05:7022:2225:b0:139:ed5d:3a5 with SMTP id
 a92af1059eb24-139ed5d0608mr6475052c88.42.1782705524129; 
 Sun, 28 Jun 2026 20:58:44 -0700 (PDT)
X-Received: by 2002:a05:7022:2225:b0:139:ed5d:3a5 with SMTP id
 a92af1059eb24-139ed5d0608mr6475033c88.42.1782705523457; 
 Sun, 28 Jun 2026 20:58:43 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL v4 02/77] configs/meson: disable hexagon idef-parser for
 emscripten builds
Date: Sun, 28 Jun 2026 20:57:15 -0700
Message-Id: <20260629035830.1520296-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX7Mg17qYoQU9N
 U4CWjATfzdCWJxagEuq4zwrDV517RUVgZEoxlXmx3ylAgEnpsMpRh9+WX4nm4ZhOT0VspQX8DHQ
 RBUqzBf9jhrZxRJ6N1bggXQC94y9AGQ=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41ed75 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=MPO-fdqQ5Q6WhVTBZRsA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: sHmUK7gfVk8AKwNX7hFihQjLG_rB4WVB
X-Proofpoint-ORIG-GUID: sHmUK7gfVk8AKwNX7hFihQjLG_rB4WVB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXyu+HGs2rzHMh
 ry2KpBwFW1Lb72SFOvkJyUDSwsq1kottsunXJUgGdnFMOPw0u4ZTgLwMf2GE7N4tKipl9qi7kt4
 xM17nH8/VYs0rcjrHmpO8rEyCzZMxEoT8OzA4Z4LwWp2o/ac+6drGpnzxYSSA9qhjDnR7bsgati
 +c99i+VVpVquFwGhe9D87xV/Eg71z7KWSHaezLQfUGp9BXv3rhv6hcIPMHPfUAql2MjFRmQj6TN
 cBF+AjkutJYaaqk7+1YHhJeuyXeVqt4Twk54yIzTGvz15X4csqkUaCUKHExar809YubXP2nk5B1
 wM0PBdFNFUqUX/Ntwnwv0lf7vNsBvIXGlb+/5AMjv+GlBF0odlFv5z7npWeRz7lxA3iP23mh6Yc
 aTNC5rjUwL6sJNPu/Cwu013xuQJejj3ZO0Nt2nvdyjvNo82KHDjfqyn3897TLvmNr+rV/Ze/pkJ
 lbAnGTn04rEhlbThAwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

VGhlIGlkZWYtcGFyc2VyIGlzIGEgbmF0aXZlIGJ1aWxkIHRvb2wgdGhhdCByZXF1aXJlcyBnbGli
LTIuMCBvbiB0aGUKYnVpbGQgbWFjaGluZS4gSW4gZW1zY3JpcHRlbiBjcm9zcyBidWlsZHMsIGVt
Y29uZmlndXJlIHNldHMKUEtHX0NPTkZJR19MSUJESVIgdG8gZW1zY3JpcHRlbidzIHN5c3Jvb3Qg
d2hpY2ggcHJldmVudHMgbmF0aXZlCnBrZy1jb25maWcgZnJvbSBmaW5kaW5nIHN5c3RlbS1pbnN0
YWxsZWQgcGFja2FnZXMuIERpc2FibGUgaWRlZi1wYXJzZXIKYnkgZGVmYXVsdCBmb3IgZW1zY3Jp
cHRlbiBzaW5jZSB0aGUgd2FzbSB0YXJnZXQgZG9lcyBub3QgbmVlZCBpdC4KClJldmlld2VkLWJ5
OiBLb2hlaSBUb2t1bmFnYSA8a3Rva3VuYWdhLm1haWxAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogY29uZmlncy9t
ZXNvbi9lbXNjcmlwdGVuLnR4dCB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvY29uZmlncy9tZXNvbi9lbXNjcmlwdGVuLnR4dCBiL2NvbmZpZ3Mv
bWVzb24vZW1zY3JpcHRlbi50eHQKaW5kZXggNDIzMGU4ODAwNWYuLmM1YzU3ZTM5MmE5IDEwMDY0
NAotLS0gYS9jb25maWdzL21lc29uL2Vtc2NyaXB0ZW4udHh0CisrKyBiL2NvbmZpZ3MvbWVzb24v
ZW1zY3JpcHRlbi50eHQKQEAgLTYsMyArNiw2IEBAIG9iamNfYXJncyA9IFsnLXB0aHJlYWQnXQog
IyBjb25maWd1cmF0aW9uIHNvIGV4cGxpY2l0bHkgYWRkIHRoZSBmbGFnIGhlcmUuCiBjX2xpbmtf
YXJncyA9IFsnLXB0aHJlYWQnLCctc0FTWU5DSUZZPTEnLCctc1BST1hZX1RPX1BUSFJFQUQ9MScs
Jy1zRk9SQ0VfRklMRVNZU1RFTScsJy1zQUxMT1dfVEFCTEVfR1JPV1RIJywnLXNUT1RBTF9NRU1P
Ulk9MkdCJywnLXNXQVNNX0JJR0lOVCcsJy1zRVhQT1JUX0VTNj0xJywnLXNBU1lOQ0lGWV9JTVBP
UlRTPWZmaV9jYWxsX2pzJywnLXNFWFBPUlRFRF9SVU5USU1FX01FVEhPRFM9YWRkRnVuY3Rpb24s
cmVtb3ZlRnVuY3Rpb24sVFRZLEZTJ10KIGNwcF9saW5rX2FyZ3MgPSBbJy1wdGhyZWFkJywnLXNB
U1lOQ0lGWT0xJywnLXNQUk9YWV9UT19QVEhSRUFEPTEnLCctc0ZPUkNFX0ZJTEVTWVNURU0nLCct
c0FMTE9XX1RBQkxFX0dST1dUSCcsJy1zVE9UQUxfTUVNT1JZPTJHQicsJy1zV0FTTV9CSUdJTlQn
LCctc0VYUE9SVF9FUzY9MScsJy1zQVNZTkNJRllfSU1QT1JUUz1mZmlfY2FsbF9qcycsJy1zRVhQ
T1JURURfUlVOVElNRV9NRVRIT0RTPWFkZEZ1bmN0aW9uLHJlbW92ZUZ1bmN0aW9uLFRUWSxGUydd
CisKK1twcm9qZWN0IG9wdGlvbnNdCitoZXhhZ29uX2lkZWZfcGFyc2VyID0gZmFsc2UKLS0gCjIu
MzQuMQoK

