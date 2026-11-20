Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131E606A8A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GK78o1DE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DDc40iC0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUTEB-00061k-Nm; Fri, 20 Nov 2026 13:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE9-00061E-JA
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:49 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUTE7-0000pJ-TJ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 13:20:49 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEffuY1527754
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UapivG8f51tWo3vDh6NSXxhp+g0QcNz6RdJgswsVvNg=; b=GK78o1DE15E73g2G
 8pTnCKEoLDReEk8CdAXD97cYVbzENyJXeCowpcq+DtQPhX/gfI7kF3SnugZP5W23
 JwFxwtFJDu9EP5pj6YzUaicKEhrH8PwbJHwBmphsssfprNQzrntY1bORwd21gv20
 mieHDH7jRoqL3mCuz+hqK02R3xxLfg/H2AI7SY8xGLetvdro/2JNLk+gusVRbKDm
 G+T6l3PK5xF49YZ2oEZ/CEt/XMnwVdrHopbMix+zbsavEeHqFfnDRQnUwpPb5F3q
 02510uoFUIy62I1iKU2C4+9Vqzhrdl+AJUK9/wo/5rrSYNb6srIAbuLR3L/72eqN
 y1WMJA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqu3et-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 18:20:46 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-8632a144987so6776a34.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795198846; x=1795803646; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UapivG8f51tWo3vDh6NSXxhp+g0QcNz6RdJgswsVvNg=;
 b=DDc40iC0qXOau6k3sSgM9S9jCeOJkpoy3o4/u7FtYRdg5qisy6GEGLpt/nakweZ/U7
 UGOhQ8Q6ssvaZFt05QRn1ljYSYGIqOcxH4xnr/fLTew0qGf/MBR6LfdkJK2wTwz0v+za
 p0p8tgBAA/MCXKx3MqImEGCnDSpzHADdfp3DtZ7hN0szTbnJougU7Bixq5C2S6m9drqZ
 rcWiqrQ+xLzYWvQ9GuztvxlVkPDMSRQfHEzxQxPQV8f5AmcymPPYD1Dsmob2YldB4dku
 O3qI898qdIhMdNt7NTu1zGVxxIA5bk+7ewWUAAcGCw1n/zLJ4AZGxqp/oJF7pcSur5dh
 yU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795198846; x=1795803646;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UapivG8f51tWo3vDh6NSXxhp+g0QcNz6RdJgswsVvNg=;
 b=A6ygBLtgbBqGeTiBanwfHe5yXHgom5AUZHENHlCL/KkgS+pjEm/2muhhABh/Pcyrf5
 0IvGtzBGZjg2+3YAQujzosmVJEUhru/GV0165fk5sCTlyFGa5bVSgO4JHXNcq30ypZyl
 6V7IhJiRJ/dIC5EJSLHBsw3PbIuNCI7x+nFldVXUP1alPgq1QVDBlew27r79Dg0Pkz2D
 VGN+xeEhwJihuPfiIf5Sr4WOvpdP3RDIcd5f8FG6VedGCRIQKLgXnUXVlUHwwlt080L5
 uxITxq3jSFZhbJHf2i/PlJ/Jc+nVREe4ybH83j+g+C4AododI7p0yv668u1C00l/ImuZ
 Eo+A==
X-Gm-Message-State: APuU4Z/CrzlSIwHawF8VChHilYZnUJ+zsxdMw9HgEUZp6cqdz6W28510
 jdXmMrjXq6Zaz3pRGKTKkdLzSlWKRSE2LPKeJ661p42CfQCJJf6/0UbyzXV7UURuhUYzVJohOoi
 CB5yzZIVeFoDsJli31ZsmHH8AarW90nCTsX/Xpfg1hnWxyvF1/hPQ7MV0wtAWjw83Gw==
X-Gm-Gg: AYBFou2FWMJRikSXBRYDqGSidS/t7AWLepG5SwUX1VA/XxNDOaJMcz/ZqyFKsFG4B+k
 VAQ4ZsFH6xrX9ikvbI824MvPI9R3q0DZjKjPIt38V7O5E7EHD3zDfre8DhmthM0IexBgSnXcbmP
 NFQ0LPTmsLwiY1sBNtCB8OMhW8gZ83D1zxGrMpb4qfCU4JLDRU6P6Q7fqKm1X76Pt5Fc9zp0RdB
 HxY+osMgo1kclSb46C/FkczvwPWs1wA5hj3dhmk6ilauSHkkrvE6ltvbV5k5WCUtOjgFIWSK6z6
 Xi7sJEPE+JS6kyvXI/K9NBGd5E/rjq8Vc+tkJPJQHsdVMBKbIW2kqpquHJv8Exk2fOJU9OO+UTk
 XLsCkC3E/LeRQryqUN4VVHe2NrVhjzxBiHjo/6aSmDGMctJwkvVippU/vw0VpGNiXC6/S2sJ5Rx
 53OwMaEJrwHVul0e0LS8TjhQ==
X-Received: by 2002:a05:6830:4487:b0:861:5cbb:8603 with SMTP id
 46e09a7af769-863158d55b4mr4609087a34.20.1795198845719; 
 Fri, 20 Nov 2026 10:20:45 -0800 (PST)
X-Received: by 2002:a05:6830:4487:b0:861:5cbb:8603 with SMTP id
 46e09a7af769-863158d55b4mr4609056a34.20.1795198845263; 
 Fri, 20 Nov 2026 10:20:45 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8631690fd36sm2698364a34.20.2026.11.20.10.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:20:44 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH-for-11.2 v2 08/12] hw/hexagon: update the glob-reg vmstate ver
Date: Fri, 20 Nov 2026 10:20:27 -0800
Message-Id: <20261120182031.560481-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX4A9kmQKn38a8
 MchQxzrqwowpsV1TkgtDQN3pgDPUk19nwv0i+JJ2SfKPRsGfCDARzs5Vf26JEhcLLs3f0FBCGmr
 Oqu9/b6dQB3bqv6dr8E+gbKLsvz6KostE03cbc1z5Xqhs3cw0WXO2InhbQTyYpQcugJWAGnMKfu
 5w1KSnlEa3NUHTVbkEadxnMSA882Byg5IHHJOrVz9h9dIBWlx/lyjappZLlbtOKZmbxTgSIVetj
 KuVabUM+QUL18ZwGecE327IaOaTtMv1dZOavhh0f6Qmxpzo7ufBS+ZVk1234StMJAROFDfYV8X7
 nKs6ZCRVNy/SelqR13lIuU5lpC7iD8fDL0s0oPfdJ9LSq1IjDfiEmabt0cI2YAQEyxF6B+bntKD
 T36+xxtphBYl28OdYM4AuzK7goP68q8Fzb94P1OpBH6JCc+kXdwo/oekcLG+jUKGHoUlt6gJlYZ
 dW/ntUP83NBe4yO0D4Q==
X-Proofpoint-GUID: u_h513K77qJwWoGm2ntRs7q5iDNKiPSG
X-Proofpoint-ORIG-GUID: u_h513K77qJwWoGm2ntRs7q5iDNKiPSG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3MyBTYWx0ZWRfX9p2cyl71ly1G
 Trg9aZbKq+uc8wuvi/WKyhlJ7FXRqQMIDI4iDjfhXvMXa3F21iYQRYYidfd9owpMkKezKowmcFF
 brpu5clLyuJ0sWDhrzzOIIRGcmZ9zwY=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b008f7e cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=yPMIFQ6QiX0x8KKfrJsA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200073
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

U2luY2UgMTEuMSB0aGUgbGF5b3V0IG9mIHRoZSBtaWdyYXRlZCBnbG9iYWwgcmVnaXN0ZXIgc3Rh
dGUgaGFzIGNoYW5nZWQuClNldmVyYWwgcmVncyB3ZXJlIGFkZGVkIHdoZW4gdGhlIHY4MSBpbnRl
cnJ1cHQvY29tbWl0L2N5Y2xlIGNvdW50IHVwZGF0ZS4KClJhaXNlIHRoZSB2ZXJzaW9uLCBhbmQg
dGhlIG1pbmltdW0gdmVyc2lvbiB0aGF0IGlzIGFjY2VwdGVkLgoKU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vaGV4
YWdvbl9nbG9iYWxyZWcuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFs
cmVnLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMKaW5kZXggOGI1MGZlYzc3MGEu
LmRkMzczZGVjOWZlIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmMK
KysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jCkBAIC00NTAsOCArNDUwLDggQEAg
c3RhdGljIGludCBoZXhhZ29uX2dsb2JhbHJlZ19wb3N0X2xvYWQodm9pZCAqb3BhcXVlLAogCiBz
dGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfaGV4YWdvbl9nbG9iYWxyZWcg
PSB7CiAgICAgLm5hbWUgPSAiaGV4YWdvbl9nbG9iYWxyZWciLAotICAgIC52ZXJzaW9uX2lkID0g
MSwKLSAgICAubWluaW11bV92ZXJzaW9uX2lkID0gMSwKKyAgICAudmVyc2lvbl9pZCA9IDIsCisg
ICAgLm1pbmltdW1fdmVyc2lvbl9pZCA9IDIsCiAgICAgLnByZV9zYXZlID0gaGV4YWdvbl9nbG9i
YWxyZWdfcHJlX3NhdmUsCiAgICAgLnBvc3RfbG9hZCA9IGhleGFnb25fZ2xvYmFscmVnX3Bvc3Rf
bG9hZCwKICAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKXsKLS0gCjIuMzQuMQoK

