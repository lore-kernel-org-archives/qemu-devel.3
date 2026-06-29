Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A68AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3du-0003EF-PX; Mon, 29 Jun 2026 00:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dN-0002fg-GC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dH-0000nE-2J
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:11 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NR4I1730178
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=; b=GZe67EYBr1QfLz0+
 Q6TnE2YlGVAaUktVvk+oFbshMOra6LfJIHbni8vPXWdoSpxM22ogStIvl9GFIj+8
 sKe+qnQSfzzpctqX3Al0aQXbFXmIFkf48c1FEqD6cbYK5ApofNSTX4fwbU4uv0OE
 x3SQE7UHIWx02gjFQxBtym1Lhuhzl9hPgSjrbuhZrqrZpNX0poi0Owwu9ca2AAZo
 rz4hRypNd9kj85CQsQ//GUl/HIDyKBTqnO1LCAtc/Fh/b6+VS/Bg7mpJ8oEnl/5a
 TGh0WQelqkSG3Y7qr3jjhoyouUgDibTP9/edU5w1w1Kn1izUnUQUGcM2Kbdzxanr
 8grxIA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7vahj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:02 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30ed664e368so70456eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707402; x=1783312202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=KlStsGFoQsCtup816wH2VIIZ0hqJxXXdlNrHDXTsllRl7W+mgUPNC4qqi3JYEmm0/y
 mnM34xlitFSy8tjLY7Z2DWsBQJTRoR4mXONgRPE4neIN/K3Eu8o2Cw4xeumFQ4gFQdfm
 XgD4b5uDyIIFUiSDfsApJBl/K2fPY1zcV44bD0SNKIy4Gvk6avoebkiGtIbZJIsW5Xt5
 TgEZ2XyQGFvByZyfEmGyzjUD2yV4bD9I6j/7yTQdyecM17+KmsIUc6XiniK3W+a2uco7
 0iVNgqJ7itB5zmsgoCclosAZ5S/yGk1o9/MX1trObyQ9Phkayicvs4yg2iONBpHEHLaW
 Da4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707402; x=1783312202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=ICA3u8yM6916gQeeM79+LbFqqxlNMmLOuGplgfHqumj3n6ZIeZbQI1imqoDdpaw7r/
 UdYA43hlAAi1Wsl6VOsbpNpyAAezXcAyZ5H4GNxrPna98I22Zs7NcnZFFfPldy/0rQ61
 MeSujQrUDaskpZiw+Iunv+mAgYPDbQdklfJFVZriZX0bO9oKn6vLPJ0SK/GxJ3FsItcZ
 b7+H6Twvf+02sKBbVM20nmuahVSfVRN+a0dxPNCegjViwt1bgeUrbQqHxHkzn6j9wSs7
 gCJibVOuNBLvX2nlXbwofAoWgltvWA0IZzkNlXI1qmfsaMcy20cbAoOXNMc3SJLzRiCR
 2WYw==
X-Gm-Message-State: AOJu0YxIL3vrhXH3bTOa7gz7TiY28OtUmiaD2HgQPujs4Bevmd6uPcrU
 yxTAjZbDlzkddolayjQEf8WGa9sRYNiYHs13QgQM9m8SJRaRPc4WDYU2iL0gD3WYm3qpEIGOgwQ
 7c0rus8FPymcCMs0T8Y6vv/rdSuOtEY6hiUZ9hZFwsnV9PZosqcIlSIyVQHE/ffeMOA==
X-Gm-Gg: AfdE7ckzPb0t252j02kk17azrlK2PO9AwGTeWmK3sEEUNbWUtUZ6M+wu3mGtfDwI0qf
 s/DKdTLN8prRl6SNi44pUuLRUzkUNlczljV2r0aiq7G04SoSCDxNA3AWZBEHcDDuxvEpt6xBzr6
 9YwZ/iQbdPEVTCCqss/BriUTmiiGA6P4smWElvNayzJBfu3k0+51QHgBm6d3BAxJr215wPnmGvj
 WdBLJiAb7F50ru9JAKvxknxkzVkc7RopoYLBjJ2XaQX/0yjAnugUpG81imOXubHTCxB5p55oGBX
 UNxfLckkcCqJLcJt533bb46bNn2LSxkXizXrbcpyFyfoPM5oquvdHQFYgGx0C20k4RR5AaHjssu
 VKO5GAuxcvlhiy0zwjezKhXtdw65+lh6D9sZu0d097ixfGvuOY6DdQ7mSJII=
X-Received: by 2002:a05:7300:de08:b0:30d:a0a0:90a1 with SMTP id
 5a478bee46e88-30da0a09379mr3759871eec.4.1782707402122; 
 Sun, 28 Jun 2026 21:30:02 -0700 (PDT)
X-Received: by 2002:a05:7300:de08:b0:30d:a0a0:90a1 with SMTP id
 5a478bee46e88-30da0a09379mr3759847eec.4.1782707401603; 
 Sun, 28 Jun 2026 21:30:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 57/77] target/hexagon: extend hexagon_cpu_mmu_index() for
 sysemu
Date: Sun, 28 Jun 2026 20:58:10 -0700
Message-Id: <20260629035830.1520296-58-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXz2uqJcjvTDw2
 QRt9fKp0ZX4ixZTaG7yjhA1ceLCKkDfM5qVS55fuiq6egPAU8Eoy/zKOXSxLHVv671JRCBvxxCC
 Wexhzc7s2xKe4yXqwGjvG/CdjXKbC7zWFRqcGdK87pW+Ajim9RbCG6/ngiGm500wX8Wd3I3Kgrm
 Vq45evu5U4aKcKN32hNaLY3v4AWCFCyAJaNme7n3NoLVuchwJsFmQqj4/siMRZV7O5LoVd3Zy5C
 iBMnZTvFXQsMHxbJ+rSt0s1cFN+imy+E+ZZTEstfD3flsKaiIDKdtP61iBQ8RNLH4qgff1yURpH
 4EDZOP+0wAOPT7X4h2plCuku75BrIZxikE+pqKTL5qY4zSmQiDqBDegTYJOkK24PqkadiPXgypl
 VI+LirBaHmwn9TVJsNOrFfigz3vpQigVaZOmOwwEIeIn067onaZowciX1ENkTewxtv+fpHo/Vd1
 JWD08enBBcYNcLwUXqg==
X-Proofpoint-GUID: xsF642NSmsbLQW_xz6l08WGw6Tl6j5Zi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX+IxMWvoy0ps3
 F/0ghBQINpldbiCJC3NKNRXB9V8GiDM6q+zfpirpfx/Ah1XcJd4Aa3Xd5shPiBlZuzzBd+wz1Cv
 3ECDdi1qJsxJWxNsO9xLIPOXA//cX3A=
X-Proofpoint-ORIG-GUID: xsF642NSmsbLQW_xz6l08WGw6Tl6j5Zi
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41f4ca cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hUoHZ09r4jABJgGRQWAA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCB8ICA4ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuaAppbmRleCA3NWEyOGZjMTBmOS4uZDE3Njc1MDMxNTYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmgKQEAgLTgsNiArOCwxNCBAQAogI2RlZmluZSBIRVhBR09OX0NQVV9IRUxQRVJf
SAogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1
cl9lbnYsIGludCBpbmRleCk7Cit2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpOworaW50IGdldF9jcHVfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CitpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAq
ZW52KTsKK3ZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQg
aGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVz
ZSk7Cit2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgbWFzayk7Cit2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpOwordm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwogdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHVpbnQzMl90IGhleGFnb25fZ2V0X3N5c19w
Y3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNjcwNjY4ODA4YTgu
LjNhZjkwZTMwYjBmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDQ3LDYgKzQ0NywzMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKIAogc3RhdGljIGlu
dCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRjaCkKIHsKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vu
dihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIGludCBj
cHVfbW9kZTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaWYgKGNwdS0+Z2xvYmFscmVn
cykgeworICAgICAgICB1aW50MzJfdCBzeXNjZmcgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9i
YWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgICAgIHVpbnQ4X3Qg
bW11ZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19NTVVFTiwgc3lzY2ZnKTsKKyAgICAgICAg
aWYgKCFtbXVlbikgeworICAgICAgICAgICAgcmV0dXJuIE1NVV9LRVJORUxfSURYOworICAgICAg
ICB9CisgICAgfQorCisgICAgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUoZW52KTsKKyAgICBpZiAo
Y3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgcmV0dXJuIE1NVV9L
RVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX0dVRVNU
KSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0KKyNlbmRpZgorCiAgICAg
cmV0dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAotLSAKMi4zNC4xCgo=

