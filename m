Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096A3CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 03:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDZ1Y-0000kn-S6; Sun, 04 Oct 2026 23:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZ1R-0000ja-9J
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:05:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xDZ1O-0007tW-WD
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 23:05:48 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695103dd496789
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 03:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Pz5d52tvWF6EiMptvQXndm
 7fWS6xN+n/hqXPKXCLDjQ=; b=Ql+i1AqHWwS5+z9wZfe5vlGUCSwW8yf9F5r1/o
 owEoG+/pXbf/HmFAPK/2o3ridYinZQo3eONBx1Te1JnFGGWPWq+VJOIbPzPLXcSB
 C6cnT9ZuoTe8tsE3N/zhg0nyWwe4dnssLjruqRflqp8BnhieUit7D7g0dGhjBpWx
 Q3kWWzepWN5E6Pu6u4u9uOUfLb5JT+awEDSe/bzaM2hhOWCax0DNXLk7HGbloJrS
 bmuMl++muxPDoGX0MFtHI8dLDSseAGNx9tBBKT28cLDoSDpU4p8w0LOt/Q6mmHc1
 cpWucLW6Vo6P6c1UPuzSC5jKj8OuulNzQCOz3F2xGSwluwkA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgyrh5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:05:42 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-14fed306427so5898811c88.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 20:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791169542; x=1791774342; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pz5d52tvWF6EiMptvQXndm7fWS6xN+n/hqXPKXCLDjQ=;
 b=DaQJNT+w4DNteiYp3AMg/Jh4B+gEV/ox7vlLnkIo3/Vuci0WHvwecwp96/SC0FID0w
 OvuxfJNdwsghCndAL0CruP/5BaNlKacnCg+yDVJ6TKi4SDlyAfNVxHUOFvQFR6u6uiB7
 dcB3PIDvG3/sSPkgLuTlcfAsVOQ+kVE+X4H5j7G7IPITudsbrE8pnVrUK6t6R3FCpmEd
 Fq5jE/UTvp41CIoSLJ/n257OPqkuPEVc3lCK0zmmBAi4VadC5Jn3OUEkAsb95GrUig2V
 p3Qw0J0F+c0CWzt/mu2PgwnnWi5IRp/IWfZ+c7YVDhtqn9qZjXM4No0OcfZCLiGtOz7Z
 qw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791169542; x=1791774342;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pz5d52tvWF6EiMptvQXndm7fWS6xN+n/hqXPKXCLDjQ=;
 b=mT0K2bAck08hY5GUW0U785iuC9Yo6FuUuJmdvYzEHAqJLk8bIIFyfmddXVXEytJ2kM
 6cYb+g9DjUAlZTiILshDMZ8V86HLY+83+0SEB+4Uf0gxyvly2Xxfnav3cYonVp/uRhiB
 T1N4c0NvyKXhh5krDE3GB1VY8WZXQ3g2E2+b24UNx9rS4eMs9PC5Br7aJxZ7MCRgZVle
 tS9vzEBe+n1vMV9Aw1zTF3tml5hCFapnvPl8UcSG3eEMYDy66rm5/u91SvE7bak0C5tq
 D/MAg4Ite5meSydU6LVgMb5BvKjto23j2hyd6Um+cnao/IDRIl6U+32RtgrJmwstk2CY
 GUDQ==
X-Gm-Message-State: AFuF++l5EnI1PES+tXT6WLx0BhFQ7WN4NAUBdnqgKOTzmReGdSImi5Pj
 N3QsjG0RySL45P5/EhEy8enT1dnsknc9UwR7WwByKzDKyvyPQfaD0vC/FtgZEPAghuO1lqohKk+
 BPdux+7le+LoA7C6jyqRP6xPceA1rLifpYT/AZxXGGlNp0Aj5SuVNxoZUTLQiqoZYww==
X-Gm-Gg: AYBFou398YxstV1c1DpwTIMuyIueFt5QbsYqQVhFP7vNG7iWZ1eSAcgOEE+RNKr/VCV
 V5P3u3gYcESZiB+dsIjOsuluV1jdz9w7nnPXm47gtHWJG99ph3veGKdIMufZ4mlL7VQrLsYcKSm
 lC3dq+Xjbeqa3ZnycDTart7UITyhRusSP2WjT6Rqj9CVvTzQ5R+ttcKg9krORGxGjXEq8JL9dRI
 p9RRukbnqUsuH/ZyR/y9c6SjszbA/S7a0KeZASNpL29irUV48UuUbQiTVMCDVWu2sUemTXNcrCk
 4gHtBKDIO+G8gmg8qOJOM5cnN3Gn03/15b5vD04M6C6mZzZe2ZWjPJDeq0f9e1zXMuAzZcCiHXb
 sOPJgyTLVOV+ED1DjuqQkGOuQryIrLBiInNZZmLrV5hQuVfzl
X-Received: by 2002:a05:701b:2315:b0:143:2984:6516 with SMTP id
 a92af1059eb24-151c463f559mr9297788c88.37.1791169540835; 
 Sun, 04 Oct 2026 20:05:40 -0700 (PDT)
X-Received: by 2002:a05:701b:2315:b0:143:2984:6516 with SMTP id
 a92af1059eb24-151c463f559mr9297749c88.37.1791169540239; 
 Sun, 04 Oct 2026 20:05:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fc872e43sm17720559c88.7.2026.10.04.20.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 20:05:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 0/2] hexagon: sys+guest regs in gdbstub
Date: Sun,  4 Oct 2026 20:05:36 -0700
Message-Id: <20261005030538.1257295-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: pMeSpEZ8IT3EIxrbkb3xJr_qQJN_o2-S
X-Proofpoint-ORIG-GUID: pMeSpEZ8IT3EIxrbkb3xJr_qQJN_o2-S
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac31406 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=W-kQ7U0J4sUd25a8b1kA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAxMiBTYWx0ZWRfX2qpL/zWs/Zt/
 oDJNHqxawPCxy0qbjgaCChzqFWQ0eBRil0kCdMDea4Am4aKF0weDPNrYADEskwLa6gJrlhoXGp8
 gz+SnqgRRqEJRWvrSsvPde3yE+4ioz4EAAgwxxkhrNPKvsEjQMytG9ov0jV2L6HR2YoRoFi1nPh
 fR8bHL/ksT+v2x0Q7Em42lVkOjsbbmE7z4977v8rOjjx3WWjXa6IWqErq9GsY/RHpjUxQMJFS71
 gOKsy+S3ZbfAmUGjuFHnasBy68MxxBvBGrPSllgM0YCgeHGbJzjxXgkbjw2wwdyhKYuaYl2GOpl
 EJ+ueawT2cGRzhSpy13HVVS9EMwnH2QVXzgGnn7EJCSQtKE1Xddg8c+sf6shEBZrtojpVhp1CCX
 cONhuFnCw1zAWVKESXczE6/Vpu4yUNn3y3UxLkPI7K57+bJIAcLjtg3tZUinNzPA4uVn7xABtev
 GP8GQbkYoJJPy6S61KA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAxMiBTYWx0ZWRfXwqOnk+pco3Lr
 YQoAGzFQDVHMDAyNmUHV2yC7tH0Uj04v2ur4pSXFMlYWDARkFsuB15NuLTiYZRfN2suYJuy3GOr
 nhdgs6eYQ3lM9IZUtrnN1I0OVZdwcOA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050012
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

QWRkIHN1cHBvcnQgZm9yIHJlYWRpbmcvd3JpdGluZyBzeXN0ZW0vZ3Vlc3QgcmVnaXN0ZXJzIGlu
IHRoZSBnZGJzdHViLgoKSW4gdjI6Ci0gdXBkYXRlZCBVUkxzIGluIGhleGFnb24tc3lzLnhtbCB0
byB1c2UgYSB0YWcuCi0gdXBkYXRlZCBoZXhhZ29uX2dyZWdfe3JlYWQsd3JpdGV9IHRvIHVzZSB0
aGUgZnVsbCByYW5nZSBvZiBndWVzdC1yZWdzLgoKVGhlIGd1ZXN0IHJlZ3MgYWJvdmUgZzMgaGF2
ZSBzeW50aGV0aWMgdmFsdWVzIGZvciBQTVUtbGlrZSBmZWF0dXJlcyBub3QteWV0LQppbXBsZW1l
bnRlZC4gIEJ1dCB0aGV5IGFjY2VwdCB3cml0ZXMgc28gd2UgY2FuIGp1c3QgdHJlYXQgdGhlbSBt
b3JlCmNvbnZlbnRpb25hbGx5IGZvciBub3cgYW5kIGZpbGwgaW4gdGhlIFBNVSBiZWhhdmlvciBs
YXRlci4gIEd1ZXN0IHN3IHJlYWRzCmZyb20gdGhlc2UgcmVnaXN0ZXJzIHdpbGwgc3RpbGwgZ2Vu
ZXJhdGUgb3V0cHV0IGZvciBMT0dfVU5JTVAuCgp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDI2MDkzMDE3NTEwOC4zNTkyMTEzLTEtYnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tLwoKQnJpYW4gQ2FpbiAoMik6CiAgZ2Ric3R1Yi9nZGIteG1sOiBBZGQgaGV4YWdvbiBz
eXMgcmVncwogIHRhcmdldC9oZXhhZ29uOiBnZGJzdHViIC0gQWRkIHN5cyByZWcgc3VwcG9ydAoK
IGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLXNvZnRtbXUubWFrIHwgICAyICstCiB0YXJnZXQvaGV4
YWdvbi9jcHUuaCAgICAgICAgICAgICAgICB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9pbnRlcm5h
bC5oICAgICAgICAgICB8ICAgNCArCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAg
ICB8ICAxMyArKy0KIHRhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyAgICAgICAgICAgIHwgIDYzICsr
KysrKysrKysrCiBnZGJzdHViL2dkYi14bWwvaGV4YWdvbi1zeXMueG1sICAgICB8IDE1NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrCiA2IGZpbGVzIGNoYW5nZWQsIDIzNiBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGdkYnN0dWIvZ2RiLXhtbC9o
ZXhhZ29uLXN5cy54bWwKCi0tIAoyLjM0LjEKCg==

