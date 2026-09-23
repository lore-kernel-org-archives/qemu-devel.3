Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17022C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qaz-0003BI-Mg; Wed, 23 Sep 2026 13:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9QZB-0000VY-Np
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:15:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9QZ9-0001np-ST
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:15:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGU3qC3106210
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=; b=bI8vZc08fa9cjGTm
 1s9f+JrPH0yzMP+ZeJHf3W2HSQDYAhjLo6kPONPnd6PbLuqcFerw181mxjEy9+Kf
 0ImLYbgn5bRXiyJPRYUtdX70QhPMVrGU5jUz1cGmxGol+ZT55IGw2ii5sBqTYWH9
 /yXApDVEjUFtgTCCf4txOWkH8chT4C6z9CnvNG0EDJ7K/RUkXDogQJ4vhAPDCxtp
 BzHZt174sfisqOl4wGaUtYEqFSHvDOLnB/IO0z014aBH1sIK5oq+Bhv1EsB/Vfm9
 5ffhlnzJ5MFvftSfnsrhAtvY67De1Hm3KbnnNnWBSNe2f5wyiXuCZjNeYH4W1hm+
 TByrqg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwh1gs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 17:15:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-868f443cbd0so736516b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790183730; x=1790788530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=;
 b=hjS5vCLcKAN4Eb2+Qa4/Gj7FDBmkPdbXnLtjdTK9Y8c8f6bPhsz4tyNxkA/cr4jefk
 5vvYpUzs5faB6ESue+7abxepD7CvlFAKMIj6QKDjZz+Sc9cVppw4VSZrmBKcHJTVw67o
 M45wRo27PWirGN5qKFUXSQ+HLqrkQjGjC7YL2+3xHD7iosPGrkibZy68Mw8v6DrYgXWk
 f7ulJBVwFTbS5lYR1iBa+r9Yoigy9osy4dOnzIhG6m7Lvt/BuzgAWg3RDGDXS5Izovq7
 PAGXgHBNyxiTAlYHKxa3a1tOWfQBKabVR/l2DdRdJeXNkVw2JdvYas47HwSXTCy1DG8A
 cp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183730; x=1790788530;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lo1MlLNtldstlwTDzjT0aSLfW7yU4cNSIdISpPvIAhE=;
 b=qVaNA7mnGkl5M7WFS4+qtPx6ZCuEzLeyB1w1z75nHy1gCi1y3Gu6YMzDUNtm4k6QOs
 6Sr0rizFxI3RbRmUPbBso/4LCQj6lwhCMRfBZM6FQ/6WC2p+bofcB/m/LP4CURCPZG/4
 K/NUhduiBzMFvIRfEyVoZK657s4aO0qsq7WSDVEhOfVCy/zGeWktJI6V3ZrGgd9sq3HN
 3zB9AethXzl0TSKcUNGkumwjEn8BkOmuJhtN2HPk2UTPvUXZzMoMlq3G5UuqYbMgqVXA
 OCXHfNb8Tr5fcm3Ub0TyOPLoCa4nt/MYs7Abmx73KpCZ3z0mSezbObheJl/mDxkpjuFv
 T0gQ==
X-Gm-Message-State: AFuF++neXSk/suNK9jzB3XInoHwSxnbR3dONzzGCuc80C9wZvnIXeikx
 n9ErnfNKwGw8tYkSRMYR3oT4WIjhuGKdtR2gY5mmTV2QfsFHNdmSuuPmMRTMKAa1qo2pf+20O7Y
 hoNHUnSbjTD/qjeL/7eEAKj/XcAp9TvWvMIZuKhE0iua9NAnvJgj83gfWJB+9fgHcbw==
X-Gm-Gg: AYBFou1lnweHev6c9VMDIXJHIqMIqW7DmS97pmhEWoNBpeQXUc9VRmeJd+496quHu0B
 IdEuSe07NZE6gur54rM9px7vFJw9Fxs+Ipnm6XVAZhbPx9E10v1hr44eFfcqpVUc4qx/x4R/Ery
 5YoqIXdEzNgd7//xYq+M/rJRH82t+1T28RDwMC79AKIPmnpN/PVtWuBJt/1/orTBudSsjbazWhY
 wsIXBJIzK7IjGIrHKHMEqo5RStkMSTZ5bt057EOzX1xjo/cT8i41cbYfkdOn+7pFzIXhBaIBFRz
 3kCf4cA2RAUaxRsP/xHyvM0blhILQ5KbmmrD0TQ3go2HP0C1QnozA/O1uKJUzfY07VyZxayzDze
 Zot98LR+1ZrFhEA5Um2xWHDTC9eJwshWZ1gUM7wQLd+62/tM=
X-Received: by 2002:a17:903:2f8a:b0:2dd:c100:80bc with SMTP id
 d9443c01a7336-2df69e1d69emr29855615ad.55.1790183729647; 
 Wed, 23 Sep 2026 10:15:29 -0700 (PDT)
X-Received: by 2002:a17:903:2f8a:b0:2dd:c100:80bc with SMTP id
 d9443c01a7336-2df69e1d69emr29855145ad.55.1790183729028; 
 Wed, 23 Sep 2026 10:15:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5f66b3sm14796035ad.73.2026.09.23.10.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:15:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v6 4/7] target/hexagon: raise an exception for HVX with SSR:XE
 clear
Date: Wed, 23 Sep 2026 10:15:13 -0700
Message-Id: <20260923171516.3794996-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923171516.3794996-1-brian.cain@oss.qualcomm.com>
References: <20260923171516.3794996-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX+MQtFgs9rwQT
 bhJ6c2HOUZamt+aMTb7G0nR+eUHXo2zxj5undystKORs44LCf/8TsLSNa+7co8xGPjyAXgCE8Ke
 oTnJExSN+oZRyUlm/BlKquj1AQz6N0A4G/15O8OgcwMos5LaGw3Kx+QjU73hVMFR23LmrAlUWo1
 wbGNTRFvFMmLMU5jSN1dHHkHPm/hjK9/z9BK5kgps8NgPcCLbeZWmdP5Zd9ddon0kl6+em5ghdJ
 z7co4O5LXwv/33j7Dv/LQs8OK4Li001IE2NITuYe9LMkBiuK2rdujE2nFJquB3EZl+OsRr5wrFO
 dJMsTY9HvD1dMQFTOBaejdVUKJCf2pzicn9+nfLjVcyoFP81++emgLeY6WD3iJho5qEqLxawqaE
 gruZHTK6H88FaxkIDyfH5uBL84igRMlY8w84gUnwN5LwOF21G4zd+C8fMXWy4xg+lj/nONzJJut
 FOo2t8hemKuZM8ekeAg==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab40932 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=zEVancPc-5b3c_FCZogA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2OCBTYWx0ZWRfX3JfYs/nWTnHH
 Qcy1liD7HVqdSJSMw2cNmruu6Ilr0gCC7T2hW48MgSapu881cr2T+fgwOELf+Lhq5v+WRGsDjDr
 ccRqaaeNnqJOy0b0l/FkAHv/6Ob1oN0=
X-Proofpoint-ORIG-GUID: eWrc_aSxOS7aWvaohqqNmRXRpv_170Ev
X-Proofpoint-GUID: eWrc_aSxOS7aWvaohqqNmRXRpv_170Ev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230068
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

U1NSOlhFIGdhdGVzIGFjY2VzcyB0byB0aGUgSFZYIGNvcHJvY2Vzc29yOiBleGVjdXRpbmcgYW4g
SFZYIGluc3RydWN0aW9uCndoaWxlIGl0IGlzIGNsZWFyIG11c3QgcmFpc2UgYSBwcmVjaXNlIGV4
Y2VwdGlvbiB3aXRoIGNhdXNlIDB4MTYsCk5PX0NPUFJPQ19FTkFCTEUuCgpDYXJyeSBTU1I6WEUg
aW4gYSBUQiBmbGFnIGFuZCBlbWl0IHRoZSBleGNlcHRpb24gZm9yIHRoZQpmaXJzdCBIVlggcGFj
a2V0IG9mIGEgVEIgd2hlbiB0aGUgY29wcm9jZXNzb3IgaXMgZGlzYWJsZWQuCgpSZXZpZXdlZC1i
eTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9m
Zi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdl
dC9oZXhhZ29uL2NwdS5oICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgg
fCAgMiArKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgfCAgMiArKwogdGFyZ2V0L2hleGFn
b24vdHJhbnNsYXRlLmMgfCAxMSArKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQvaGV4
YWdvbi9jcHUuaAppbmRleCBiMTUzMzY4MGJkNy4uOTdmNjg5ZmRhMjIgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMDcsNiAr
MjA3LDcgQEAgc3RydWN0IEFyY2hDUFUgewogRklFTEQoVEJfRkxBR1MsIElTX1RJR0hUX0xPT1As
IDAsIDEpCiBGSUVMRChUQl9GTEFHUywgTU1VX0lOREVYLCAxLCAzKQogRklFTEQoVEJfRkxBR1Ms
IFBDWUNMRV9FTkFCTEVELCA0LCAxKQorRklFTEQoVEJfRkxBR1MsIEhWWF9DT1BST0NfRU5BQkxF
RCwgNSwgMSkKIAogR19OT1JFVFVSTiB2b2lkIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihD
UFVIZXhhZ29uU3RhdGUgKmVudiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCBkODYyODM4M2Yx
ZC4uYjg3YTJiMjBlMmYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisr
KyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC04OSw2ICs4OSw4IEBAIHR5cGVkZWYg
c3RydWN0IERpc2FzQ29udGV4dCB7CiAgICAgVENHdiBicmFuY2hfdGFrZW47CiAgICAgVENHdiBk
Y3plcm9fYWRkcjsKICAgICBib29sIHBjeWNsZV9lbmFibGVkOworICAgIGJvb2wgaHZ4X2NvcHJv
Y19lbmFibGVkOworICAgIGJvb2wgaHZ4X2NoZWNrX2VtaXR0ZWQ7CiAgICAgdWludDMyX3QgbnVt
X2N5Y2xlczsKIH0gRGlzYXNDb250ZXh0OwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9j
cHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IGZhZDUyNmNjZmI1Li4xOTQ4NmUwZjc0
MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKQEAgLTM0MCw2ICszNDAsOCBAQCBzdGF0aWMgVENHVEJDUFVTdGF0ZSBoZXhhZ29uX2dl
dF90Yl9jcHVfc3RhdGUoQ1BVU3RhdGUgKmNzKQogICAgIGhleF9mbGFncyA9IEZJRUxEX0RQMzIo
aGV4X2ZsYWdzLCBUQl9GTEFHUywgTU1VX0lOREVYLAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY3B1X21tdV9pbmRleChlbnZfY3B1KGVudiksIGZhbHNlKSk7CiAgICAgaGV4X2ZsYWdzID0g
RklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBQQ1lDTEVfRU5BQkxFRCwgMSk7CisgICAg
aGV4X2ZsYWdzID0gRklFTERfRFAzMihoZXhfZmxhZ3MsIFRCX0ZMQUdTLCBIVlhfQ09QUk9DX0VO
QUJMRUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBHRVRfU1NSX0ZJRUxEKFNTUl9YRSwg
ZW52LT50X3NyZWdbSEVYX1NSRUdfU1NSXSkpOwogI2Vsc2UKICAgICBoZXhfZmxhZ3MgPSBGSUVM
RF9EUDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1NVV9JTkRFWCwgTU1VX1VTRVJfSURYKTsKICNl
bmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuYwppbmRleCBmZDFkZTg3NDA1Yy4uMGNiM2RiZTU0MjAgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5z
bGF0ZS5jCkBAIC03MjAsNiArNzIwLDE0IEBAIHN0YXRpYyB2b2lkIGdlbl9zdGFydF9wYWNrZXQo
RGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgICAgICBpID0gZmluZF9uZXh0X2JpdChjdHgtPnBy
ZWRpY2F0ZWRfdG1wX3ZyZWdzLCBOVU1fVlJFR1MsIGkgKyAxKTsKICAgICAgICAgfQogICAgIH0K
KworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaWYgKGN0eC0+cGt0LnBrdF9oYXNfaHZ4
ICYmICFjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCAmJgorICAgICAgICAhY3R4LT5odnhfY2hlY2tf
ZW1pdHRlZCkgeworICAgICAgICBnZW5fcHJlY2lzZV9leGNlcHRpb24oSEVYX0NBVVNFX05PX0NP
UFJPQ19FTkFCTEUsIGN0eC0+cGt0LnBjKTsKKyAgICAgICAgY3R4LT5odnhfY2hlY2tfZW1pdHRl
ZCA9IHRydWU7CisgICAgfQorI2VuZGlmCiB9CiAKIGJvb2wgaXNfZ2F0aGVyX3N0b3JlX2luc24o
RGlzYXNDb250ZXh0ICpjdHgpCkBAIC0xMjM5LDYgKzEyNDcsOSBAQCBzdGF0aWMgdm9pZCBoZXhh
Z29uX3RyX2luaXRfZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNlICpkY2Jhc2UsCiAjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkKICAgICBjdHgtPm51bV9jeWNsZXMgPSAwOwogICAgIGN0eC0+
cGN5Y2xlX2VuYWJsZWQgPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIFBDWUNMRV9F
TkFCTEVEKTsKKyAgICBjdHgtPmh2eF9jb3Byb2NfZW5hYmxlZCA9CisgICAgICAgIEZJRUxEX0VY
MzIoaGV4X2ZsYWdzLCBUQl9GTEFHUywgSFZYX0NPUFJPQ19FTkFCTEVEKTsKKyAgICBjdHgtPmh2
eF9jaGVja19lbWl0dGVkID0gZmFsc2U7CiAjZW5kaWYKIH0KIAotLSAKMi4zNC4xCgo=

