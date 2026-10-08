Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C31CA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvNY-00051L-0n; Thu, 08 Oct 2026 17:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEvNW-000518-5k
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:10:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEvNU-0001hi-8d
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:10:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0QD13387184
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=B2rUhOJWJMCKberojRqyOo
 q6kYHcTB2tdmF0149aDLA=; b=nMBwRBZtBa+9HG0fxr/m6Z75bBCvavVjEBeptp
 m7J9RzVIB3+1mpHJS6cl5WjXAP3nTsvszifJclADM2LyIcXVv9ejCuj0a10w4k27
 q3ubQMce4qGSB1JppZS/B134VvwEyjBZqUi+UDPl11VkcUW4HhmUsN35mBVQ9NXR
 9ITJM3NirP8+ZAW0Njv+AXaiYaw5CAzwYtMXOi/t4jQAg6zsiuTiU0qttCWY6T76
 aaGXrDfVk3uQyoLCU1LmeK36wORevCIetLEubd75gJ0NrP2zcEtFy2C1QSM6gPEI
 p7nSXR9aNDJn8IxGb+gID0TWL5O3e/+192oBD+idGFxnp33w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrrpb0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:10:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-152d1363a29so11672407c88.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493809; x=1792098609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B2rUhOJWJMCKberojRqyOoq6kYHcTB2tdmF0149aDLA=;
 b=VTMT/g42oH89o4YN1Kk2il9WryyvcQj/YenXdYmGxk4l5iMpxOFDDTqaRzediQpsyG
 jAspQsbPANvXnMVGjM4PXCPcLutckFX8vrunLGCekofMkUoyM+x33FCK4NeJzF1uNxt0
 pPla5FmhvchoXu1l87pEUWjCgKT5oMCN+g72TYxPA6kqvIgN8zD4dLDcaT/1O2hpHCSv
 xc1Z55JvmnE/l3Ck6gW6PYbKWGfcwc+YpmLgcON2enUwuH54fKoNdx/+nqHkyWagbCh4
 xeLlowPiyAIg8810SvqaMJIIt629Ib4ET4KSRPpB9LTXngp7asn8am3PZJRJU1ucg89u
 ydpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493809; x=1792098609;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B2rUhOJWJMCKberojRqyOoq6kYHcTB2tdmF0149aDLA=;
 b=NNUJH5RxKlbdHhqtcypdionZ1awuHZjT7+QVGKnYLhuJIrqeofRHGFDumcQjS6QdH6
 oc6IKKXuDmdojFAeFzNwUbFf/ZCC62XJO9/x60pz0WK7mbjPOJlFTPsYjdg2eiLXPo+4
 8sv1pXGGFpy9V6T3e6XcUo0ZwNeevtP79/pd4IKZQWy0I2hcWHEBowwugIU+Ynv1PBta
 GBo8OQsc9KGBs/ATY3zadaoQndpKTlThj5jd1lZRhiAWoVfJOkVcNvjTOJMuuh0/wQfa
 pFC2RN074zFIA0NP71UGu2D3y61LcmXkHI0SLScirHv88Bpg0sGk4SltaPkFECxPBVoZ
 mpMQ==
X-Gm-Message-State: AFuF++nXk6JUF+g8RFmUc0b3xyzPxxhjcoMaKWZ8sy5TySYBU5bWtHoo
 UOe7tWJM40hxZktOEyTAyDH7qQRqwUCuUQAYe5vzFfb0M0bB3QMJI8mcbohAopyeoenQnQ/Ku01
 XrYYOrqyQsB7lS+aut9PTuqqkKgadXGcPQnZXOmkN5jkgaMpW9ZP9npOO4rpXpz9P8A==
X-Gm-Gg: AYBFou2cPoVnGNNGWlbejHR49gC4MhPAnF2KpMFAT7RO12bB7RA8b5LVHvq+FLSC7SG
 2wtkkeHaRph81NQM0xukjtwIovopnDMZ/GK1RzfkJdoHytq4+mI8Rw95yoMj7sPyqQ0IgLVkzgW
 w41+LSRQRZ7mDAX46tZe9XRf60zcGKF+lmHSjAKtWT4u7c4CNbhr1q084FNF3P7W1NRioFxqc08
 69vJ5fyZHKy+dBdBdw8TLqpuD/gNPCBHPZ09bNKZUOUi3bkFr6pcDmbGudC8gW+D6a9/WPYAHoN
 yfOpnQQ/fSzJPjAXTOqqq2EZ70gO9kzlp5MpIJPxz9Xi/L5m06vwhZ0RwLxLwGx3mnhD5QCMrQ9
 20OxJnbUxSWumSl2pGFCKBf+/qPQkfinbjf7xV2EZysO2Y8s=
X-Received: by 2002:a05:7022:1717:b0:151:d6e5:596b with SMTP id
 a92af1059eb24-16a12ee6324mr55517c88.9.1791493808772; 
 Thu, 08 Oct 2026 14:10:08 -0700 (PDT)
X-Received: by 2002:a05:7022:1717:b0:151:d6e5:596b with SMTP id
 a92af1059eb24-16a12ee6324mr55450c88.9.1791493807312; 
 Thu, 08 Oct 2026 14:10:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a31f6be0sm1628501c88.13.2026.10.08.14.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:10:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, ltaylorsimpson@gmail.com
Subject: [PATCH v2 0/4] hexagon: Remove wait{,_next_pc}
Date: Thu,  8 Oct 2026 14:10:01 -0700
Message-Id: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac806b1 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Vca9YIHfF-qQfpDqMDoA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: b-uqujmshE33m6h-35jiIoUbxY6CDbwF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfXzlK5qgB1irFu
 UW9D9tHRaRNehh8XQly4NQQV9FExTBBRj8pN5bj0/lmcvZRkljy0klZyeS8R3Zn4q73tMgIekM+
 /Nniw5gMbX6v/bwzRbOgXarJVMB9TTtczPbVUowh4vpiw5duQDpszACucDpVk7zrMc2TNt2NTxh
 jMmdV0MYdmNc8UiJRcF7M4zGS41dHK8uLs1LhGYx4GSUiwT93+wACqWriSsrU43EboskNahQifK
 c2wjdNxTOE5+OMmuR0wXwVjjbDnLDz/d7CrVGJ1zEFENh39ug8UxcHhce9KteVDABLfBtGs/B03
 3wx7wB5aZHR793LMoWXnWTZ/I0DfPXfUgD8qN8ci/pK+Ix/bt9Kav9ErvdO2QXB7x25wa+41aJp
 vSz4ebKyFXoRJ9ELm/r3iIqlCl/GiR2CbUFMC6w1lR1HgP1Xdwnm1FN1a2uMMmvKv3LDUTfi8ex
 SfwbGAiw0HZzgE8+1Dg==
X-Proofpoint-ORIG-GUID: b-uqujmshE33m6h-35jiIoUbxY6CDbwF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX5MSHLvN7Kj0m
 DN1NTz1nOY9JkNKLgGde/Ano69yMNSkZo1Ffitihho2H3qcffQZlSfh/hYOYNRXzBeqeB1GIFfv
 6ldW9joDYKUFNAOhjfH0XCHvUIhvplk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

SGFuZGxpbmcgdGhlIFBDIHVwZGF0ZSBiZWhhdmlvciBmb3Igd2FpdCwgbG9ja2luZyBpbnN0cnVj
dGlvbnMsIENPRgpldGMuIHdhcyBtYW5hZ2VkIHdpdGggZXh0cmEgc3RhdGUuICBCdXQgaWYgd2Ug
cGFzcyB0aGUgY3VycmVudC1wYWNrZXQgUEMKdG8ge2swLHRsYn1sb2NrLCB0aGV5IGNhbiB1cGRh
dGUgUEMgd2hlbiBwZW5kaW5nLiAgQW5kIHByZWxvYWRpbmcgdGhlIFBDCndpdGggdGhlIG5leHQg
cGFja2V0IGFkZHJlc3MgYmVmb3JlIGV4ZWN1dGluZyBpbnN0cnVjdGlvbnMgdGhhdCBjb3VsZCBl
bmQKYSBUQiBsZXRzIHdhaXQoKSB1c2UgdGhlIFBDIGRpcmVjdGx5LgoKVGhpcyBzZXJpZXMgbWFr
ZXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuICBUaGUgYGJlc3R3YWl0YCB0ZXN0IGNhc2UsIHdoaWNo
CmV4ZXJjaXNlcyB0aGUgd2FpdCBpbnN0cnVjdGlvbiBhbmQgdGhlIGhhcmR3YXJlIHNjaGVkdWxl
ciBmZWF0dXJlIGhhcyBiZWVuCmFkZGVkLCBidXQgdGhpcyB0ZXN0IHBhc3NlcyBvbiB0aGUgYmFz
ZWxpbmUuCgpXb3J0aCBhIHNlY29uZCBvcGluaW9uOiB0aGlzIHNlcmllcyBtb2RpZmllcyB0aGUg
Q1BVIFZNU3RhdGVEZXNjcmlwdGlvbgpidXQgZG9lcyBub3QgdXBkYXRlIHRoZSB2ZXJzaW9uX2lk
LiAgSSBwbGFuIHRvIGNvbnRpbnVlIG1ha2luZyBjaGFuZ2VzIGFsb25nCnRoZXNlIGxpbmVzLCBs
ZWFkaW5nIHVwIHRvIHRoZSAxMS4yIHJlbGVhc2UuICBJIGhvcGUgdGhhdCBpdCdzIGFwcHJvcHJp
YXRlL3ZhbGlkCnRvIG9ubHkgdXBkYXRlIHRoZSB2ZXJzaW9uX2lkIHRvIGNhcHR1cmUgY2hhbmdl
cyBiZXR3ZWVuIHJlbGVhc2VzLCBub3QgbWVyZWx5CmNoYW5nZXMgYmV0d2VlbiBwdWxsIHJlcXVl
c3RzLgoKSW4gdjI6CgotIFN3aXRjaGVkIHRvIFRBUkdFVF9GTVRfbHgKLSBSZW1vdmVkIHVucmVs
YXRlZCBub2lzZSBoZXhfdGxiX2ZpbmRfbWF0Y2goKSBjaGFuZ2UKLSBEcm9wcGVkIHRoZSBzcGVj
aWFsIGNhc2VzIGZvciBZMl9rMGxvY2sgYW5kIFkyX3RsYmxvY2sgaW4gaGV4X2NvbW1vbi5weQot
IFVzZSBjdHgtPm5leHRfUEMgY29uc2lzdGVudGx5Ci0gQ2xhcmlmaWVkIGNvbW1pdCBtZXNzYWdl
IGZvciAncGFzcyB0aGUgcGFja2V0IFBDIHRvIGxvY2sgaW1wbGVtZW50YXRpb25zJwoKdjE6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjA5MTUxNTQ1MDIuNDEwNjU5Ny0x
LWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJyaWFuIENhaW4gKDQpOgogIHRhcmdldC9o
ZXhhZ29uOiBwYXNzIHRoZSBwYWNrZXQgUEMgdG8gbG9jayBpbXBsZW1lbnRhdGlvbnMKICB0YXJn
ZXQvaGV4YWdvbjogc3RhZ2UgdGhlIFBDIGluIHRoZSBQQyByZWdpc3RlciwgZHJvcCBuZXh0X1BD
CiAgdGFyZ2V0L2hleGFnb246IGRyb3Agd2FpdF9uZXh0X3BjCiAgdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uOiBhZGQgYmVzdHdhaXQgc3lzdGVzdAoKIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgLS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lzLmggICAg
ICAgICAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2hlbHBlci5oICAgICAgICAgICAgICAg
ICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2hleF9tbXUuaCAgICAgICAgICAgICAgICAgIHwg
IDIgKy0KIHRhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaCAgICAgICAgICAgICAgIHwgIDQgKyst
LQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmggICAgICAgICAgICAgICAgfCAgMiAtLQogdGFy
Z2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMiAtLQogdGFyZ2V0L2hl
eGFnb24vY3B1X2hlbHBlci5jICAgICAgICAgICAgICAgfCAgOCAtLS0tLS0tCiB0YXJnZXQvaGV4
YWdvbi9nZW5wdHIuYyAgICAgICAgICAgICAgICAgICB8IDE0ICsrKy0tLS0tLS0tLQogdGFyZ2V0
L2hleGFnb24vaGV4X2ludGVycnVwdHMuYyAgICAgICAgICAgfCAgNCArLS0tCiB0YXJnZXQvaGV4
YWdvbi9oZXhfbW11LmMgICAgICAgICAgICAgICAgICB8IDE2ICsrKysrKysrLS0tLS0tCiB0YXJn
ZXQvaGV4YWdvbi9oZXhzd2kuYyAgICAgICAgICAgICAgICAgICB8ICAyICstCiB0YXJnZXQvaGV4
YWdvbi9tYWNoaW5lLmMgICAgICAgICAgICAgICAgICB8ICAyIC0tCiB0YXJnZXQvaGV4YWdvbi9v
cF9oZWxwZXIuYyAgICAgICAgICAgICAgICB8IDI1ICsrKysrKysrKysrLS0tLS0tLS0tLQogdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgfCAyNyArKysrKysrKysrKyst
LS0tLS0tLS0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgfCAg
MyArKysKIDE2IGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDY4IGRlbGV0aW9ucygt
KQoKLS0gCjIuMzQuMQoK

