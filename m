Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8359606B784
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nJ8u1E2l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f+c+II89
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8YW-0002o7-IB; Thu, 19 Nov 2026 15:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YJ-0002ll-Hm
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YH-0000qY-IU
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:15 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJemv93279105
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 juZrxqHUpIm/ImEGWCh1BIS8AF0/lU1ZIhsBhD0LY/U=; b=nJ8u1E2lxdk+s5du
 dm5BTpyUPVNqc8/RW6jYf/r8zP4iVUjzsuDxIfZaYgoSSL+aadoTzFdokR8ylPm1
 sAPRu7sdeYFQl92LfNnN1vPfIXCImIL/rRrVDkk9It9AHTRmEecKgJLRVSR/Yid5
 ZpFXx2NK9ePVgUZsUbst1owmSTHUBUTMAPZFxIUYiMhJ/gytpDSg8690qH9OX+a8
 l560+WqGU8+QgdgbUGXn8ZeM1FQD4rGN7lC0iGdKQJu5FAHcl3pLSsGundJY6XiA
 tJOC0+Jx9TfoZdAAmVOvTnc/gxZadakqTh0D8mQkOdyYtsCTEJs5p9yJFF29UJX1
 dv1/+Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fyg4a7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375bac6bd21so100903eec.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119372; x=1795724172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=juZrxqHUpIm/ImEGWCh1BIS8AF0/lU1ZIhsBhD0LY/U=;
 b=f+c+II89VB5M5eVx32Z2y15JM317ioiD6xtSpdQ5eRQTFDQScOZE4+cXwE/nqvXa3U
 GvO6rDhWix/I4vCcGCmgI/fxpGpjAvC88kZ4FvISLN2tb3S08mTn6T6bxOEZ04REu+P/
 QM4Es2lTtoYbg+DnYaSPaxVX8ZwE6vA+anSHi5yFnl84RKgubPUT/1zOuLtKXVbYuTTQ
 4Xb4mlV9htzUeWJGvkGTre/E90YKLohFf7MiCKCafPpnkuYsLROOaPJabCMJ00UsM7Ma
 OI/8e1rM8SspWL0xFiTXxr7/qLl93yaglUvVLWKR7hleJ9jZc0Q+C+BA03gHyMHLIF3X
 pMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119372; x=1795724172;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juZrxqHUpIm/ImEGWCh1BIS8AF0/lU1ZIhsBhD0LY/U=;
 b=E2MIMpYLeV+BXITMIrx23C2zbq6Djh/zxf31rZ+d0nEZQ8Qz6I5Hz5U952+Qie9KY2
 aKpKYx54CjSmu3hfpFD8h5AeP32huK4+abdJl3yC+AfZEpo39aL822pPaCrHGmP1FvQE
 UOIV8CuTivFTjzdPWM3byOFhdfxZ/BB6GqcQ5XB3mdrlMzvAsLAx726MObMQlSCBQrFP
 vq5iiiKvdHaiaMwdrA9l9vlPYctWmtPCyBlB+6Uiki++SNSnjwvVnA3yfzNOraXIZvtz
 8mXV7YfqJR8G2Pi/7F/WrNKtX9HGg1n5dxXjbLZTYpDVnaXRInzSadEc9DlEJJ8UQRii
 4J0Q==
X-Gm-Message-State: APuU4Z+FNoXT3YCLxmt9ZSuaGt2CMcAPtOzpgR5CEVRwUBhjEAOptN1z
 i6+TINEg7FdlbQda7BtaHVxKh0XhCqyqyuqais/rnz/N+C/+0HLLivxzlJ6lpzeBldBtC8BiSvZ
 d63HXILuezd5/SX4TqKK1uyNLoqp35J52bRuvKLnmqCGq0aszvhDHA5EUlx3qjdglwg==
X-Gm-Gg: AZFdTZdIQMS2Z0Tl/gwK+Oy8ki+4nCD3BOQAjFa712EQNfCnz/VgIHMk5dXD1BbUEnH
 R8G+G2UVdL0YGqo7hS/o3aRgIae52KUyOf2dm8VRw08jF7EplAGVIP5yHxLnz2r62ErS4yr4t3M
 MDy5PIJQjPi10pgsZ6SCa+6PHsSuTLhwdv2m+LBlr7vki0WbhUAmL9DjknpwWGqb12nAECNCMkv
 1gpiiETNZsknEUgNHAyzJxNdW3qB0sEDMqlAaqyRdJLwCqzWu4qP36DAo6z8MNyz8rVYjD4IcmS
 p4vW9eeounwDbHJ9yVVaiN2Ahx4krmTit6FjOvkjCWgkCo1szBSbrGqNERRKDggvDHvFAcS8KGG
 wJDoHM9foGLhX+SKbW7mpJSuemhGZULm4hGpzfVfUYgOkTusmR5DlQS12YhW8BHg1/GbzkpzgE5
 JIwixG9QXOHTNvQ/084GKjMg==
X-Received: by 2002:a05:7300:cd86:b0:36c:a3ae:936e with SMTP id
 5a478bee46e88-384b398741bmr2600303eec.5.1795119371484; 
 Thu, 19 Nov 2026 12:16:11 -0800 (PST)
X-Received: by 2002:a05:7300:cd86:b0:36c:a3ae:936e with SMTP id
 5a478bee46e88-384b398741bmr2600265eec.5.1795119370911; 
 Thu, 19 Nov 2026 12:16:10 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:09 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 04/14] target/hexagon: deliver floating point
 exceptions after the packet
Date: Thu, 19 Nov 2026 12:15:53 -0800
Message-Id: <20261119201603.2377989-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX6fbsSGscY2U3
 Qw6ilCuM+7PgXOivZQCCZjNHp2DPfeFPEI5YTpBYtQYF9K1qGknGj7f46QIQQqxMc1nQ7+zjULn
 N5qa/g5gIF2+dYVR4uEQfp7Ey9pXs88=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfXwO5+rXQiq7V0
 7phZr3J+z85Lt+wnIcDlPLAbcxL7EtFGGR7edk67HkNRv6f0c50M/+x40Xs36vDUE7/RDYicZbu
 U1XvK0JvkwrCeZrZQe4cV2EiCNvsCo3dl3KqRwsH721ScC3Iz6h1rdQttEwlSrmEmlL8QetgQim
 C94RiyzuiSS1unZCEhjDz6Dz8RqBQNh9xr+H7E9RnNYUb4bnLGJKriCh0AE1iuZJJkoBredeG/n
 nZDcRTraubWvXFnaIOfoHlF6wXuCbl/y1imkF+MtNK9q8XzUmBco0/fRikh6HoJUZn6nlaWFCQW
 NqRw6i+ABiIoclpG/4x7zvVmgzNBZ9E8bfsBVCSD6thVnwapY3neYZEHzOgsHtLvL+mkG/Ruh4J
 UCv8xb5fTSzQgWGFyRFuL5m6XgrkPQTfjRVDhMUZGIOpLtanCE24EmTJcMNMx1MSwh4yCWRK4iY
 1n2oilU0oFPawu31zmA==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6aff590c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=WGR0rWkjfx4cIdXbClMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: ptFDuHQi7RDKEsRQnQHW21CBoOCD81tk
X-Proofpoint-GUID: ptFDuHQi7RDKEsRQnQHW21CBoOCD81tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190080
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

QW4gdW5tYXNrZWQgZmxvYXRpbmcgcG9pbnQgZXhjZXB0aW9uIHVzZWQgdG8gdGFrZSB0aGUgZXhj
ZXB0aW9uIGluIHRoZQptaWRkbGUgb2YgdGhlIHBhY2tldCwgd2l0aCB3aGF0ZXZlciBQQyB3YXMg
bGFzdCB3cml0dGVuLiAgVGhlCmFyY2hpdGVjdHVyZSB0YWtlcyBpdCBhZnRlciB0aGUgcGFja2V0
IGNvbW1pdHMsIGxpa2UgdHJhcDAsIHNvIHBlbmQgaXQKdGhlIHdheSB0aGUgVExCIHBlbmRzIGFu
IGltcHJlY2lzZSBleGNlcHRpb24gYW5kIHJhaXNlIGl0IGF0IHRoZSBlbmQgb2YKdGhlIHBhY2tl
dC4gIFJlcG9ydCBFTFIgYXMgdGhlIGxhc3Qgd29yZCBvZiB0aGUgcGFja2V0IHNvIHRoYXQgYSBo
YW5kbGVyCnJlc3VtZXMgYXQgdGhlIG5leHQgcGFja2V0IGJ5IGFkdmFuY2luZyBFTFIgYnkgb25l
IHdvcmQuCgpUaGlzIGVuYWJsZXMgdGhlIGZsb2F0X2V4Y3Agc3lzdGVzdC4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9hcmNoLmMgICAgICAgICAgICAgICAgICAgICB8ICA5ICsrKysrLS0tLQogdGFyZ2V0
L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICB8IDEwICsrKysrKysrLS0KIHRlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5IHwgIDUgKysrKysKIDQgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXggNWVlODdiMzIwYjYu
LmRkYmNiYTljZGQwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMTQsMTMgKzIxNCwxNCBAQCB2b2lkIGFyY2hfZnBvcF9z
dGFydChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAqLwogI2RlZmluZSBSQUlTRV9GUF9FWENFUFRJ
T04gICBkbyB7fSB3aGlsZSAoMCkKICNlbHNlCisvKgorICogRmxvYXRpbmcgcG9pbnQgZXhjZXB0
aW9ucyBhcmUgdGFrZW4gYWZ0ZXIgdGhlIHBhY2tldCB0aGF0IGNhdXNlZCB0aGVtCisgKiBjb21t
aXRzLCBzbyBwZW5kIHRoaXMgb25lIGZvciBjaGVja19pbXByZWNpc2VfZXhjZXB0aW9uKCkuCisg
Ki8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OIFwKICAgICBkbyB7IFwKLSAgICAgICAgQ1BV
U3RhdGUgKmNzID0gZW52X2NwdShlbnYpOyBcCi0gICAgICAgIGNzLT5leGNlcHRpb25faW5kZXgg
PSBIRVhfRVZFTlRfRlBUUkFQOyBcCisgICAgICAgIGVudi0+aW1wcmVjaXNlX2V4Y2VwdGlvbiA9
IEhFWF9FVkVOVF9GUFRSQVA7IFwKICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNF
X0ZQVFJBUF9DQVVTRV9CQURGTE9BVDsgXAotICAgICAgICBkb19yYWlzZV9leGNlcHRpb24oZW52
LCBjcy0+ZXhjZXB0aW9uX2luZGV4LCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYt
PmdwcltIRVhfUkVHX1BDXSwgMCk7IFwKICAgICB9IHdoaWxlICgwKQogI2VuZGlmCiAKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMK
aW5kZXggYWNjNjhhYTZjMjMuLjk2ZDRhNzgzZWQ0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwpAQCAtOTcyLDYgKzk3Miw3
IEBAIHZvaWQgaGV4YWdvbl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcykKICAgICAgICAg
YnJlYWs7CiAKICAgICBjYXNlIEhFWF9FVkVOVF9GUFRSQVA6CisgICAgICAgIGVudi0+aW1wcmVj
aXNlX2V4Y2VwdGlvbiA9IDA7CiAgICAgICAgIGlmIChldmVudF90b19ndWVzdChlbnYsIENDUl9H
RUUpKSB7CiAgICAgICAgICAgICBndWVzdF9ldmVudF9lbnRyeShlbnYsIGVudi0+Y2F1c2VfY29k
ZSwgZW52LT5ncHJbSEVYX1JFR19QQ10sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBI
RVhfR0VWQl9IV19GUFRSQVAsIGZhbHNlKTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggNDFhMGYyYjA4NTIu
LmVlZjM5MmIxZTljIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMTM0NSwxMSArMTM0NSwxNyBAQCBzdGF0
aWMgdm9pZCB1cGRhdGVfZXhlY19jb3VudGVycyhEaXNhc0NvbnRleHQgKmN0eCkKICNpZm5kZWYg
Q09ORklHX1VTRVJfT05MWQogLyoKICAqIEEgdGxicCBpbnN0cnVjdGlvbiBtYXkgZGV0ZWN0IG11
bHRpcGxlIFRMQiBtYXRjaGVzIGFuZCBzZXQgYSBwZW5kaW5nCi0gKiBpbXByZWNpc2UgZXhjZXB0
aW9uLiAgUmFpc2UgaXQgYWZ0ZXIgdGhlIHBhY2tldCB0aGF0IHJhbiB0aGUgdGxicC4KKyAqIGlt
cHJlY2lzZSBleGNlcHRpb24sIGFuZCBhIGZsb2F0aW5nIHBvaW50IGluc3RydWN0aW9uIG1heSBz
ZXQgYSBwZW5kaW5nCisgKiBmbG9hdGluZyBwb2ludCBleGNlcHRpb24uICBSYWlzZSB0aGVtIGFm
dGVyIHRoZSBwYWNrZXQgdGhhdCBjYXVzZWQgdGhlbS4KKyAqCisgKiBBIGZsb2F0aW5nIHBvaW50
IGV4Y2VwdGlvbiBlc3RhYmxpc2hlcyB0aGUgZXhjZXB0aW9uIHBvaW50IGFmdGVyIHRoZQorICog
cGFja2V0LCBsaWtlIHRyYXAwLiAgRUxSIGlzIHRoZSBsYXN0IHdvcmQgb2YgdGhlIHBhY2tldCwg
c28gYSBoYW5kbGVyCisgKiByZXN1bWVzIGF0IHRoZSBuZXh0IHBhY2tldCBieSBhZHZhbmNpbmcg
RUxSIGJ5IG9uZSB3b3JkLgogICovCiBzdGF0aWMgdm9pZCBjaGVja19pbXByZWNpc2VfZXhjZXB0
aW9uKERpc2FzQ29udGV4dCAqY3R4KQogewotICAgIFRDR3YgUEMgPSB0Y2dfY29uc3RhbnRfdGwo
Y3R4LT5wa3QucGMpOworICAgIFRDR3YgUEMgPSB0Y2dfY29uc3RhbnRfdGwoY2hlY2tfZm9yX2F0
dHJpYigmY3R4LT5wa3QsIEFfRlBPUCkgPworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y3R4LT5uZXh0X1BDIC0gNCA6IGN0eC0+cGt0LnBjKTsKICAgICBUQ0dMYWJlbCAqbGFiZWwgPSBn
ZW5fbmV3X2xhYmVsKCk7CiAKICAgICB0Y2dfZ2VuX2JyY29uZGlfdGwoVENHX0NPTkRfRVEsIGhl
eF9pbXByZWNpc2VfZXhjZXB0aW9uLCAwLCBsYWJlbCk7CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IDc2ZTI0ODBjMWQzLi42MDY1NjcyMzBiOSAxMDA3NTUK
LS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKKysrIGIvdGVz
dHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTgyLDYgKzgyLDExIEBA
IGRlZiB0ZXN0X2Z0cnVuYyhzZWxmKToKICAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChvcy5wYXRo
LmdldHNpemUoZnRydW5jX3BhdGgpLCAxLAogICAgICAgICAgICAgICAgICAgICAgICAgICJfdGVz
dGZpbGVfZnRydW5jIHNob3VsZCBiZSAxIGJ5dGUgYWZ0ZXIgZnRydW5jIikKIAorICAgIGRlZiB0
ZXN0X2Zsb2F0X2V4Y3Aoc2VsZik6CisgICAgICAgICIiIlVubWFza2VkIGZsb2F0aW5nIHBvaW50
IGV4Y2VwdGlvbnMgYXJlIHRha2VuIGFmdGVyIHRoZSBwYWNrZXQKKyAgICAgICAgdGhhdCBjYXVz
ZWQgdGhlbSBjb21taXRzLiIiIgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImZsb2F0X2V4
Y3AiKQorCiAgICAgZGVmIHRlc3RfYWNjZXNzKHNlbGYpOgogICAgICAgICAiIiJhY2Nlc3MgY2hl
Y2tzIFJfT0t8V19PSyBvbiBfdGVzdGZpbGVfYWNjZXNzLiIiIgogICAgICAgICB0ZXN0ZmlsZSA9
IHNlbGYuc2NyYXRjaF9maWxlKCJfdGVzdGZpbGVfYWNjZXNzIikKLS0gCjIuMzQuMQoK

