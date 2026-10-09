Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C0BCA9EC1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFGEK-0007OM-Lc; Fri, 09 Oct 2026 15:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGED-0007N8-5I
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:26:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xFGEB-0007e9-7U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 15:26:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZWfV3584200
 for <qemu-devel@nongnu.org>; Fri, 9 Oct 2026 19:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 In8vci4v76thQFPF77fQlRu22pjnMqcJ0oLZQnueqWE=; b=IDyOCS11ATy8+spc
 WhTt6FZnvUA5GJwoGZiY42Ofbzf4Yaj2JivukKXHJqxTmR96j44oQnIvGGvgLXs8
 M5beVxoNhaRC3KTGT6thSUp+O+n4ED/A051s8gDklu0A6ECTvNtQrdOKq9qemYC4
 9+i63jgvzHPcce8C62jKE46XYLDKzk8OZFonOZM8pvCZeYJV0kQeOrQmlkXQ/4j0
 RpDdYXUwilPcOVSSpbm8sDScWrpTWJ9nTRAWQ+2fMy3GZUBNl7jYkwAfzRNplCFv
 zI78fiPutsJpeDecvn1XQcRkGg+OG4rrAnVdSxFVy2+tMYz6pVGUYbQgTqWs1mQL
 Zf1/XA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t70e8y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 19:25:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso7277322eec.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791573956; x=1792178756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=In8vci4v76thQFPF77fQlRu22pjnMqcJ0oLZQnueqWE=;
 b=JGM97UkV1A8URymNp4lDi+KCh0FHNZRoOEYFlR7O5pVPt8QcO2GYh94qTgMC7Ky5pl
 gHzqN4m/R3ltFK1yK8HYTrT1w2y0Ue8+VIk1zjgd8bRtaGhwARO2xmtez3gBKpVR7cIF
 vTxuGE0sABrVdY6rpWHTpp8tIycD3mMpmwZ0Yq4GP22KssUBQ3t0z4lDdOE7VPzQ3Nd3
 aTPH2aQl3Tfd/EGZaNOKwS86GWw8od3kpL+/+dsm1cZGuinDk/JApZsSjLr8uDDGQ+8A
 erB00qpYlVN/1Juh47FGFIqtjpjEq0NjrZZPlMH3SMAZpzqdL8bW+4n2e/Gl1PLvoeZz
 JIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791573956; x=1792178756;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=In8vci4v76thQFPF77fQlRu22pjnMqcJ0oLZQnueqWE=;
 b=GqwVmk2d893TUQaQUSH/yrpUFgYwR/B4y84b1YZjCCkN7ylQoCrPKlW4GtiA9AfjoA
 J8Siq4YWvuzrVNtNS+MAPSairNmhCserdBdl+/wQwIveTim8FRTRv0Qxk/+MNFXMS5OP
 HPP9QChSErV3Zw0hGR/afIxj7rzAgqf0VK2pqoVLuIQTyRh42zw0qhFIV1eQRyYEPuJ2
 AHdB1AW+M3PMvcWS9yFYljfFRRbl5836u0Kv4CIDr/603IcjtwFwg08mXFILo5/oaACj
 9gryYkBrLfMq4BF0KfgoVe48nn4qsNHq74XhfGdcsX880dMiWINZKLFBszsNyG+peULo
 TkxA==
X-Gm-Message-State: AFuF++mt7UxCCC+GqLVBBhOxbnZgunzgghEY7nFSK2KwkbW50j9kueBR
 Er8nMTSYSO1DTEijY9Aat/yDJKrZcCbBZOm6edHGW3HR6Vym+r+7TKPVcJFlf/ohm/1sI8goGYs
 xqwq179rzUfI94HCm/680gC5QGLIFpn0nMg0WSl7jtYj1AuWsYrlTktJu6sZZsZMXpw==
X-Gm-Gg: AYBFou3l/wUaazXLJGaSqzhEYd92vsOvphf+saexWywsDWbyUVZzm9F6ahH+WNUhjTA
 tAsJWudTyQq4BpoyfX0qKwOoAGx6xY8Pxe5Hj5CAQdCpVP+vnUlxL15J53fLDMQQ8YUHgGrB1xu
 aVWXXif+0KoJ3/c7QV6+SicD2z9N1cBiqgx00NrhwxOQ59W+WDTjHHwLxsGIE4zRG8FC+rSVRB/
 sVEnWPt1CIsFBzTNJbuuwi1Ree28wI5Zcj+ChTpiCxTaBEkJDGvX/J/kjxU37QdiP315fyorjsB
 rSvUzefgXEm1kTu2sNeQ5j0TrZImxQS++LAw6xQStNBR3jmEwr2ki5yPS3S6PAKzTI4J6ohOJbw
 9FhVsakmSldXhhdFrUvSbcWTax6jHN/VzKNxE/k7M8G8RnNU=
X-Received: by 2002:a05:7022:e804:b0:13c:f65c:d5b5 with SMTP id
 a92af1059eb24-16a0b37d130mr3925908c88.3.1791573956427; 
 Fri, 09 Oct 2026 12:25:56 -0700 (PDT)
X-Received: by 2002:a05:7022:e804:b0:13c:f65c:d5b5 with SMTP id
 a92af1059eb24-16a0b37d130mr3925863c88.3.1791573955704; 
 Fri, 09 Oct 2026 12:25:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d202sm7652822eec.13.2026.10.09.12.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 12:25:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/6] target/hexagon: set a started thread's enable bit when
 start retires
Date: Fri,  9 Oct 2026 12:25:39 -0700
Message-Id: <20261009192541.4163758-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
References: <20261009192541.4163758-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: s1ykgnh9z5xfA_X1jJhPdrIqQI__4oDY
X-Authority-Analysis: v=2.4 cv=Mbr5KJ/f c=1 sm=1 tr=0 ts=6ac93fc5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=u35ek3RR3RME6NZFTgcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfXyM8+e9WpTwlK
 03cyN22PBK6bc1UMQejpvHXd7BQ+VjY7iXvwQ2qMEgpIR8WZhC2xdL8yNiLxDln6+SNM65mGQxC
 k4stSyRw6wdfsqoVylAXHXP1ML/w+DY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NyBTYWx0ZWRfXwu/mnK/YbdJ0
 g8e5TwqzCuiFBzC0DiuQjkcXQoJP3lP5z7Ki0aettHwQ4q8hcAmYAWg2Gy4QKDcR14oyVCLihNn
 SSKmkowMVCFFGXvlBPvFito8Sihd8tyx/QidouBmIFytyZnRkQe8+WBQbDa6TaK4vCmOTck4mii
 SPkqlABmkpKSDrjdd/EmHxD+HYK8B5XczKXbrCvSa1joLL66EKKTSamZFEHz4IngTCdRYp1c2aP
 dcRApic0oH7IU+6XqLz7sZ8NzXTeq1xPOwD0B7Q/V7i8YX8TcDsW4L5kpdlKJ97A+D9QU/9O8vF
 xwGYc7q25Nxga5sQIJjxXStYZzYgm3HnWuBnMkrCh313Gk3lZAotQMCcugKu03L863ez+hy+8fb
 3IfOBEykedRUiKZzAQfLepmU2Ae9ciTpksQcIVQAH9vfhZskd5XTMP831vyL1EvU+23Q3PvhUiA
 SP4vWypUuH1bnV9p02w==
X-Proofpoint-GUID: s1ykgnh9z5xfA_X1jJhPdrIqQI__4oDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090077
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

U2V0IE1PREVDVEwuRSB3aGVuIHN0YXJ0IHJldGlyZXMgcmF0aGVyIHRoYW4gd2hlbiB0aGUgdGFy
Z2V0IHRocmVhZCBydW5zLiBUaGlzCm1ha2VzIHRoZSB0aHJlYWQgc3RhdGUgdmlzaWJsZSB0byBz
b2Z0d2FyZSBpbW1lZGlhdGVseSBhZnRlciBzdGFydC4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVf
aGVscGVyLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9jcHVf
aGVscGVyLmMKaW5kZXggMGNjOGVjODkwZGEuLmRmMzA2ZmNjZDZiIDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5j
CkBAIC01MDQsNiArNTA0LDkgQEAgc3RhdGljIHZvaWQgZG9fc3RhcnRfdGhyZWFkKENQVVN0YXRl
ICpjcywgcnVuX29uX2NwdV9kYXRhIHRiZCkKIHZvaWQgaGV4YWdvbl9zdGFydF90aHJlYWRzKENQ
VUhleGFnb25TdGF0ZSAqY3VycmVudF9lbnYsIHVpbnQzMl90IG1hc2spCiB7CiAgICAgQ1BVU3Rh
dGUgKmNzOworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKwogICAgIENQVV9GT1JFQUNIKGNzKSB7
CiAgICAgICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CiAgICAgICAgIGlm
ICghKG1hc2sgJiAoMHgxIDw8IGVudi0+dGhyZWFkSWQpKSkgewpAQCAtNTExLDYgKzUxNCw3IEBA
IHZvaWQgaGV4YWdvbl9zdGFydF90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqY3VycmVudF9lbnYs
IHVpbnQzMl90IG1hc2spCiAgICAgICAgIH0KIAogICAgICAgICBpZiAoY3VycmVudF9lbnYtPnRo
cmVhZElkICE9IGVudi0+dGhyZWFkSWQpIHsKKyAgICAgICAgICAgIHNldF9lbmFibGVfbWFzayhl
bnYpOwogICAgICAgICAgICAgYXN5bmNfc2FmZV9ydW5fb25fY3B1KGNzLCBkb19zdGFydF90aHJl
YWQsIFJVTl9PTl9DUFVfTlVMTCk7CiAgICAgICAgIH0KICAgICB9Ci0tIAoyLjM0LjEKCg==

