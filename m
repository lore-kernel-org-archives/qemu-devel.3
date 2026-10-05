Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49688CA5FE2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZLN-000846-0P; Sun, 04 Oct 2026 23:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZLM-00083j-1A
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:26:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZLJ-0000of-Du
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:26:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6950xrcq495759
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 03:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=nlLSk/E5cEJhk+Ynh9Vq3f
 Lkz/BcuFmDMn1BuyvhhnM=; b=URQGt1MouzUr7Lj3eB+ytjnsobVIj/pw476pUG
 MDm8cAfpCx71cgJZPPwRYdtn69H0rxqAPzCj30O8VtZGpKb3t7nCCCrUVnd0nRag
 EGoYdxDU9sDFjbbHAEAwzib+xXNBYhZfyLPPauA/g1Gn3bQnQ7gU/ewZecJI3Hub
 gSFxgvua+rvqihxfAtjQR3C4oYyzVcRr1+AH0RFk2JR3BovvWFyVSA5qcuuHbGIt
 weTrMzgvYWNs9eBUhJK20n9StAlJtIzBGvtdbXcRq/Ej1niqThGBcVkgMvTOgJmu
 u0Kc1mC1sduW/jV2FjTRI1U4jnbvqU1LjGuXnK55PpVYRl8Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgyrjbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:26:19 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1384427c3efso1666224c88.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791170778; x=1791775578; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nlLSk/E5cEJhk+Ynh9Vq3fLkz/BcuFmDMn1BuyvhhnM=;
 b=LqKMF6btls/C1I9PMFX+8khx8ZKiib0NjVHym6LXDfOgbn+wqjSyCvPBUGFX43ugig
 QP3EjyxJbc9K9SkfF+onRqRULwFBh/Lo2qiMWU+td+v6PbQFWJkQEHknnbs0c+9PsNYD
 71064gsy2WM2QiG8s5hyAUtIzab2jrbmTlvHTasKKEtY8O/m/VbV6e3Ik7OhFjpKKAe/
 Qmu379GLLqNnZhcukSoCjhSGAXWJy+sWI92gk0Aw2EsbCDBeQbTY9vC+5/BjQ1qsa3nw
 Sq4XO5qqOq8rK5kxJp3de/gRfx5+h2kult+BMTUCgEtzQEq8HzkPStQXNW22uxFaswo6
 2STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791170778; x=1791775578;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nlLSk/E5cEJhk+Ynh9Vq3fLkz/BcuFmDMn1BuyvhhnM=;
 b=ao7cELVivzH1KfjpzJ2UfM6nGTkQUbpOl/LdjS4z0fDu0EvN43uGdE7Gz0mDjAYEX6
 7bFZvCOYgKm9Whm5RQHEYTTc5RjIr9onv6viTwDAyIo2qZuSTYXsmgch2xNBOsmJ/LD/
 vVEgpoFzl5t1TvU2/7TG5Wk8S2zHQ12uJ9Y84H/z8nj707Br2UJXBU7T2ItFQa0Dti1n
 /91jFplHoA9XHyHUdOOktu50tE9OLxhV4HWDbLvAQ0TYm9XHBl7GrHUZlXnYmRHGd/zb
 8dpnKEmp3kGeEaYM3ZrtZU+Ia/S+xZpnVQty5n506PnF6Sneh2nfg2J2o+ly03LoarX/
 L9MQ==
X-Gm-Message-State: AFuF++lnd3WyNNUyI5fPkzwLY5ANj1SrhG6xlN9MYpM+dp7u7i/fwukh
 iBL7B8PCiF7cM+w8LWluaIZ9V1DOsNKTWfozTxwT9kMzyVgTEG29e6SAog0nhUBzYqVo+vh/cCR
 SnEZQ0lP1XAolFxG8Trfq1agAJzCrORJmkNGseQdy0URMtwB28i97bdZG7/PFGTUKBw==
X-Gm-Gg: AYBFou2KTst6ZVYT9tVh9geZ/7jFkf+Ij0zMMQEL+FtAH+XYgQhXoNT3RCEVusiuaW3
 IlBmeHlCD4ZGNBbzr9lICBHsU20ovd38b6fQWtZDAiL8Ak+N2WSdVCgEiLqph4ufwGu82FeQKh/
 Ti6tivLUhCsDaY+Fa9TyM41Marey1Fqs5WB8Hf0tuALN9650PmQKhS8Nj1lC/amqdk3Kmc7atqk
 xFF0HYwqwZRszVm8aBh4RrocEV2Hj7W0+YFDcNtwBszf913amwBwPOy6ukNKcf0rm7omlECYSca
 vbfFubQIVmpb3ftxhyI3m8TZZudn+TIox3P4iILX8EfYejd/5mUkTNMqbPBYprs7H/Qsh8qBaS9
 ZlO3CDdTZ2GtqghoDNtl6rf2753NAWVkNnei6T6JpICsxLz0=
X-Received: by 2002:a05:7023:a4d:10b0:155:524c:b080 with SMTP id
 a92af1059eb24-155524cb4f2mr4826741c88.18.1791170778176; 
 Sun, 04 Oct 2026 20:26:18 -0700 (PDT)
X-Received: by 2002:a05:7023:a4d:10b0:155:524c:b080 with SMTP id
 a92af1059eb24-155524cb4f2mr4826721c88.18.1791170777515; 
 Sun, 04 Oct 2026 20:26:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fcd83fadsm18596255c88.11.2026.10.04.20.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:26:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, richard.henderson@linaro.org,
 Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com
Subject: [PATCH v2 00/10] Hexagon: Add HVX floating point
Date: Sun,  4 Oct 2026 20:26:06 -0700
Message-Id: <20261005032616.1293829-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: M4TGJDYHoQyCHP5iifb36SqfHMal22UG
X-Proofpoint-ORIG-GUID: M4TGJDYHoQyCHP5iifb36SqfHMal22UG
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac318db cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_r8ElANk4QmVXsA6dP8A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfXy7xQ8bGus2eT
 LGnIKe/9NAotXgdS7ELKrNOzRdLmsQ0CqjFhT2OLCRZktTn5OcqN38LQ8edNhMWBvkcqz4Z/6Vk
 1ENuhEEsqe3dLfzRPFQumfoeCFJ9PXQBtNocO1zn9GKQUbdha99opzWQOB1wMa9FVvrsfY0wyLX
 BntXg6T7kcVmK6d8QaCaSDN+6/FPlLAulk/859iv+bF5p08ttngBpZLo+/yhwLEsvH1JmlnEiTT
 YycR7Anhkp0qV4OfWUCko9hn+CiIdYmCnUDoCTUEW1EqhfCIcmH4oQvJ4h7AuuXaBZ0l+xnBa5Q
 3UpOf3bOQmKbuh9gWZgypQK4R7isDtUuSHJ1aAG6z8wFTxDn7pS/LcLclbwhOWemy2hsr2VD63I
 Zk280JS9e9d2fb6HKXA9/UVTKapXqRfmNmvPSuYtkz5d2mRgmKj/ehWF6sKJiiQ3Cv4A2venAxu
 Ry39vTIERP4OBr/gQJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMyBTYWx0ZWRfXzPDmFwLjMYrT
 AYMCHQOBhnEx6uqjqobmPWXyjBDNzkRFAHpyJlY8Hpb38EabsQhWHsDYSyrP0CikpM8LsFHZbMI
 tYcp1XhhEdDr/woiSIQ6NIDWLVudYoU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050013
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

SFZYIGZsb2F0aW5nIHBvaW50IChha2EgUUZsb2F0KSBpcyBhIGZsb2F0IHJlcHJlc2VudGF0aW9u
IHRoYXQgY2FuIGJlIHVzZWQKYXMgYW4gYWx0ZXJuYXRpdmUgdG8gSUVFRSBmbG9hdGluZy1wb2lu
dC4gIFRoZSBjb252ZW50aW9uYWwgdXNlIGNhc2UgaXMgZm9yCmxvYWRzL3N0b3JlcyB0byB1c2Ug
SUVFRSBzaW5nbGUvaGFsZiBwcmVjaXNpb24gYW5kIGNvbXB1dGF0aW9uIGxvY2FsIHRvIHRoZQpE
U1AgdXNlcyBxZmxvYXQuCgpBbHNvOiBleHRlbmRlZC1xZmxvYXQgc2VtYW50aWNzIGFyZSBwcm92
aWRlZCBmb3Igdjc5IGFuZCBsYXRlci4KCkluIHYyOgotIEhWWCB3cml0ZSBjb25mbGljdHMgYXJl
IG5vdyBsb2dnZWQgYXMgZ3Vlc3QgZXJyb3JzIHJhdGhlciB0aGFuIGRlY29kZQpmYWlsdXJlcy4g
cS1yZWcgY29uZmxpY3RzIG5vdyBiZWhhdmUgbGlrZSB2LXJlZ3M6IG9ubHkgbXVsdGlwbGUgd3Jp
dGVzCmluY2x1ZGluZyBhbiB1bmNvbmRpdGlvbmFsIHdyaXRlIGNvbmZsaWN0LgotIFVwZGF0ZWQg
d3JpdGUtY29uZmxpY3QgdGVzdHM6IGZvcm1lcmx5IGlsbGVnYWwgSFZYL1EtcmVnaXN0ZXIgY2Fz
ZXMgbm93CmNvbnRpbnVlIHcvbyBleGNlcHRpb24uICBUZXN0IGlucHV0cyBhcmUgdGlnaHRlbmVk
IHRvIHZhbGlkYXRlIGJlaGF2aW9yLgotIEhWWCBzdG9yZXMgY29weSBvbmx5IE1BWF9WRUNfU0la
RV9CWVRFUy4KLSBRRmxvYXQgZml4ZXM6CiAgLSBwcmVzZXJ2ZSBleHQgYml0cyB3aGVuIGEgcHJl
ZGljYXRlZCB2ZWN0b3Igd3JpdGUgaXMgbm90IHRha2VuLgogIC0gdmNvbnZfaF9oZl9ybmQgYWx3
YXlzIG5lYXJlc3QtZXZlbiwgaGFuZGxlIE5hTnMgYXMgc2lnbmVkIElOVDE2X3tNSU4sTUFYfS4K
LSBBZGRlZCBjb3ZlcmFnZSBmb3IgZmFsc2UtcHJlZCBleHQtYml0IHByZXNlcnZhdGlvbiwgVVNS
LkZQUk5EIG1vZGVzLCBOYU4KY29udmVyc2lvbi4KCk9uIHRoZSB2MSB0aHJlYWQgYmVsb3csIHRo
ZXJlIHdhcyBzb21lIGNvbmZ1c2lvbiByZWdhcmRpbmcgdGhlIFBSTSBhbmQKcGVyaGFwcyB0aGUg
dGV4dCBjb3VsZCBiZSBjbGVhcmVyLiAgV2Ugd2lsbCBmb2xsb3cgdXAgd2l0aCB0aGUgYXJjaGl0
ZWN0dXJlCnRlYW0gdG8gc2VlayBhbiB1cGRhdGUgdG8gdGhlIFBSTS4gIEluZGVlZCwgb24gdGhl
IHJlYWwgZGV2aWNlLApWNl92Y29udl9oX2hmX3JuZCByb3VuZHMgdG8gbmVhcmVzdCBldmVuLCBp
bmRlcGVuZGVudCBvZiBVU1IuCgp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC8yMDI2MDkyNjE5MjMzOC4yNzAyOTUyLTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoK
QnJpYW4gQ2FpbiAoMTApOgogIHRhcmdldC9oZXhhZ29uOiBBbGxvdyB0ZW1wb3JhcnkgSFZYIHdy
aXRlIGFuZCBmdXR1cmUgd3JpdGUKICB0ZXN0cy90Y2cvaGV4YWdvbjogQ292ZXIgSFZYIHZlY3Rv
ciB3cml0ZSBjb25mbGljdHMKICB0YXJnZXQvaGV4YWdvbjogYWRkIHY4MSBIVlggY29tcGFyZSwg
YWxpZ24sIGFuZCBjb252ZXJ0IGluc3RydWN0aW9ucwogIHRhcmdldC9oZXhhZ29uOiBmaXggVjZf
dmNtb3YgcmVzZXJ2ZWQtYml0IGVuY29kaW5nCiAgdGFyZ2V0L2hleGFnb246IHVzZSB2ZWN0b3Ig
cGF5bG9hZCBzaXplIGZvciBIVlggb3BlcmF0aW9ucwogIHRhcmdldC9oZXhhZ29uOiByZXNlcnZl
IGludGVybmFsIEhWWCB2ZWN0b3Igc3RhdGUgZm9yIFFGbG9hdAogIHRhcmdldC9oZXhhZ29uOiBh
ZGQgdGhlIFFGbG9hdCBsb2dpYwogIHRhcmdldC9oZXhhZ29uOiBzZWxlY3QgUUZsb2F0IGluc3Qg
c2VtYW50aWNzIGJ5IHJldgogIGxpbnV4LXVzZXIvaGV4YWdvbjogYWRkIHY3NS12ODEgSFdDQVBz
CiAgdGVzdHMvdGNnL2hleGFnb246IGFkZCB2ODEsIGV4dC1RRmxvYXQgdGVzdHMKCiBkb2NzL3N5
c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgICAgICAgICAgICB8ICAgOCArLQogdGFyZ2V0L2hl
eGFnb24vZ2VuX3RjZ19odnguaCAgICAgICAgICAgICAgICAgfCAyNDIgKysrLS0tCiB0YXJnZXQv
aGV4YWdvbi9tbXZlYy9odnhfaWVlZV9mcC5oICAgICAgICAgICB8ICAgMyArCiB0YXJnZXQvaGV4
YWdvbi9tbXZlYy9tYWNyb3MuaCAgICAgICAgICAgICAgICB8IDExOSArKy0KIHRhcmdldC9oZXhh
Z29uL21tdmVjL21tdmVjLmggICAgICAgICAgICAgICAgIHwgIDkwICstCiB0YXJnZXQvaGV4YWdv
bi9tbXZlYy9tbXZlY19xZmxvYXQuaCAgICAgICAgICB8IDEzMyArKysKIHRhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oICAgICAgICAgICAgICAgICAgIHwgIDIwICstCiB0YXJnZXQvaGV4YWdvbi9y
ZWdfZmllbGRzX2RlZi5oLmluYyAgICAgICAgICB8ICAgMiArCiBody9oZXhhZ29uL2hleGFnb25f
aHZ4X2NvbnRleHQuYyAgICAgICAgICAgICB8ICAgNSArCiBsaW51eC11c2VyL2hleGFnb24vZWxm
bG9hZC5jICAgICAgICAgICAgICAgICB8ICAgOSArCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAg
ICAgICAgICAgICAgICAgICAgICB8ICAxOCArLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X2ll
ZWVfZnAuYyAgICAgICAgICAgfCAgMjQgKwogdGFyZ2V0L2hleGFnb24vbW12ZWMvaHZ4X3FmbG9h
dC5jICAgICAgICAgICAgfCA4MzEgKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24v
bW12ZWMvc3lzdGVtX2V4dF9tbXZlYy5jICAgICAgfCAgIDggKy0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jICAgICAgICAgICAgICAgICAgIHwgIDM0ICstCiB0YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYyAgICAgICAgICAgICAgICAgICB8ICAzMSArLQogdGVzdHMvdGNnL2hleGFnb24vY2hl
Y2tfcmV2X2dhdGluZy5jICAgICAgICAgfCAgMTIgKy0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9l
eHQuYyAgICAgICAgICAgICAgICAgIHwgMjQ4ICsrKysrKwogdGVzdHMvdGNnL2hleGFnb24vbXVs
dGlwbGUtd3JpdGVzLmMgICAgICAgICAgfCAxMDcgKystCiB0ZXN0cy90Y2cvaGV4YWdvbi9xZmxv
YXRfdjgxLmMgICAgICAgICAgICAgICB8IDExOSArKysKIHRlc3RzL3RjZy9oZXhhZ29uL3Y4MV9o
dnguYyAgICAgICAgICAgICAgICAgIHwgMjU5ICsrKysrKwogdGFyZ2V0L2hleGFnb24vdGFnX3Jl
dl9pbmZvLmMuaW5jICAgICAgICAgICAgfCAgNTQgKysKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2df
ZnVuY3MucHkgICAgICAgICAgICAgIHwgICAyICstCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9u
LnB5ICAgICAgICAgICAgICAgICB8ICA5MyArKy0KIHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL21t
dmVjL2VuY29kZV9leHQuZGVmIHwgIDYzICstCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tbXZl
Yy9leHQuaWRlZiAgICAgICB8IDIzNSArKysrKysKIHRhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgICAgIHwgICAxICsKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgIHwgIDI1ICsKIDI4IGZpbGVzIGNoYW5nZWQsIDI1ODEgaW5zZXJ0aW9u
cygrKSwgMjE0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29u
L21tdmVjL21tdmVjX3FmbG9hdC5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24v
bW12ZWMvaHZ4X3FmbG9hdC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24v
aHZ4X2V4dC5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vcWZsb2F0X3Y4
MS5jCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdGNnL2hleGFnb24vdjgxX2h2eC5jCgotLSAK
Mi4zNC4xCgo=

