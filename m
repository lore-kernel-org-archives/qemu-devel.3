Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93221CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Ds-0004qC-M2; Fri, 29 May 2026 17:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dr-0004jD-8X
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dp-0000uM-4P
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2H65198959
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ky/H7YxLHQOYPT9iE+BJy1Z59BoP2RFeVcUJDUu2pwg=; b=QA93oUinwTGksg91
 kyn0IQB9N4WCv61BdTuXnjpd73Em2p+XexcfhWUp7Iyv/2ZQqv7R2Ro0Mb05El2F
 tDy+qozhM8OtB022BhZx0TuNmV7LDMbtibqK5135SDDBG32zDSUO0XGJd3t2fMoB
 4+xi54lGKOBiSlVMA1QHf4vXPt/FHftaJBH3wIpTStTD6FBrQLOoFVMgqS9OKbHS
 nbCSCwn+DDhEHtnnCgmpt/NFDxNuO1CHtKLjyFRRYGRKoCe5j6C12/qNTcEA/xh+
 J4aA14GTmMKyYT+bQN3Ckny2gjjRqS2WDs8Ok46k8+palbtV97hpwvLz8HMjCszU
 x1Pjag==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efdjnhxwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ee7d1368so936393eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091907; x=1780696707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ky/H7YxLHQOYPT9iE+BJy1Z59BoP2RFeVcUJDUu2pwg=;
 b=QKABO4ObFF/xOgIEi/e3a/FgvV4jF4fAa1j4NIQy0cVdj7RhiFGGqjEVWfnTmKiE0i
 3ahZVv6ctdnG6stuYqi68Or/NNXmQepNHBiOlQHtoxTJwlOQFa7lcBt7Qvkdc3O1DfdB
 ZaXPRyOyPhPWUYpSwdBgX6mxhcEoUiwLgmhmGdiA3n1CXN5LnihYsL/MiXxzpg1qpGSb
 tQ7gewSr4pu78ixycaOHRTpmB8KvXsG64x6Sl11zoqhI2jnCtnXdS7uszqmChf0fTszM
 sRoJ239dMbw39cav/mjBsHV2+byk90Klz1oETlP8/oSIw//SBSe2T9qh31vLvb1KocTQ
 PEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091907; x=1780696707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ky/H7YxLHQOYPT9iE+BJy1Z59BoP2RFeVcUJDUu2pwg=;
 b=Nb0tsefzIF7ugFl7YjHllezM1RqBvQjMj1vmBSicP4moOmGWsSMPnzknHVEC/4DlI2
 6OcRMZSRQqQxYNpbodPLjUTq4pnfTlVUxNPZwuIbN3e2Qg++hw+7gmgnritqbMXyc0ZM
 YZWDXf23uOGcHv6DSsDUpdBRsDnKIs7wk0XZKlwM/jEwZvt+svKvPtwCDF77gV9o48Zo
 DqIHVfd81TprOlI2ww7jPajNg7kg2FtgpO/qv/kHTaxkgPcToJvKTRv0lkz34JU3FjIl
 JPEJFE9AQvyJO4vBdLs3nQ7J3tPxQ4GcHZmPbj9uMTkatPFpDp6WSk40Bc6Ul+VFrDPz
 4WDQ==
X-Gm-Message-State: AOJu0Yzs2EnN8y3U4B74qdwkJ1+WCjdGZ+8IeAK0O0wKqSNBu1fgA55r
 n5+Vdm96K7vEU26I3KTSBtxtaxgd00PFZtsbAn8b0NS7I/HvxbMi1nzAtiZHIXWdHl+GtjBHJWv
 Xnf9fqvEpCjCwwA5WymKW6U+6cEuyaX7yVRstiSJ1nH4+P5CIU253Gti9Zm5ewNXKeA==
X-Gm-Gg: Acq92OG09VEYuK5KPostzjIuBk/mFUua6rkewPNg9bumOkGWtvjvABTohgeltoZWk29
 gOo4GoWxnL8H3OTVW7VCzQi4emZB+/fek3Bns12Ncogs/Va/FDtd0q9ijm+BbJT0YbCyPzY4oYs
 wB/O+KCPx3TvNZxmbPTiTkmw11L9ew0nYsWVXeMMSZhY40NqE5k2BoSIbLkMXIMj4hEG4+y3D3u
 IhCWx00g/tO83sbgfxiKkaJMwwCa8MPEPEcIdx429wMoOrXLPojyTNgrwswZynoW2c1YYaPbSnB
 A8ilDziuCZYW/E3Je++kK5KBCo4nNOYT2NqgJXEtrQxxLQpceY0nS0UjZKiXjJ9/ojM/aYIy7D0
 jehSTgwda8ybfH5HQ3Mp743IAMMnCH8lsf3BeaxfzoAN5/15mfPBqx7Q/4qgP5i0qxbPjNvqImo
 OW4uik
X-Received: by 2002:a05:7300:e683:b0:304:de26:3cb6 with SMTP id
 5a478bee46e88-304fa61b98cmr849321eec.23.1780091907186; 
 Fri, 29 May 2026 14:58:27 -0700 (PDT)
X-Received: by 2002:a05:7300:e683:b0:304:de26:3cb6 with SMTP id
 5a478bee46e88-304fa61b98cmr849305eec.23.1780091906683; 
 Fri, 29 May 2026 14:58:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 12/28] target/hexagon: Implement hexagon_tlb_fill()
Date: Fri, 29 May 2026 14:57:50 -0700
Message-Id: <20260529215806.608770-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX4CDzyEvRRAHI
 Qk8ViZVcXWuKb5u2nK2jf+SwxY31uDMRDc2mfvqYDBZwVowPCSNiZwLigo3dNQAy25jNyM3czaO
 Xl4xZYnQhfAnG7XJXMviCSXIy8c5ddnkxOTNQBmSl9VDfeBs7M38f+yvf3UcbbJZIJE/2iBui07
 GOQBELW/CNbshzkVMNZ2dz1eZfz/kqIc/u/cKJWVC+qEgnnYQxxibqmydb3FbhyagLfhqt8kL2E
 2ncYcmfou5RozW4TgI6lccKsu2Jw9W3nD9SkSqbFO6XEXXTsePM50sl/+MsoHT3CR+jmx6/836F
 wHWDeB02oxjFJ5CU+873JWSk+mLcaAYZ9KqeQjfJjdwqoTiA0qRfN4qHw2QqTtLHrupKB2E9/GE
 gH62wUVzinEa7cAmPaNtsuNHLRpQSJAJH7qRWfKWg9NU6XckeSzVIFdxZE17A3B5x54msvCYQ2f
 GoOLWd/O6X3q5nDQpqg==
X-Proofpoint-GUID: nhEIkAsxLO0wOhbR3rJ5nhd59zgVpiyz
X-Proofpoint-ORIG-GUID: nhEIkAsxLO0wOhbR3rJ5nhd59zgVpiyz
X-Authority-Analysis: v=2.4 cv=PtKjqQM3 c=1 sm=1 tr=0 ts=6a1a0c04 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=yz7b9sy1sBSXNk6fZdQA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMTM1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCAxMzUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggYjRjZjQ3Y2RmN2UuLmE3ZjFh
NzVhMTY1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4
YWdvbi9jcHUuYwpAQCAtMzgsNiArMzgsOCBAQAogI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgi
CiAjaW5jbHVkZSAiaGV4X2ludGVycnVwdHMuaCIKICNpbmNsdWRlICJleGVjL2NwdS1pbnRlcnJ1
cHQuaCIKKyNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCisjaW5jbHVkZSAiaHcvaGV4YWdv
bi9oZXhhZ29uX2dsb2JhbHJlZy5oIgogI2VuZGlmCiAKIHN0YXRpYyBPYmplY3RDbGFzcyAqaGV4
YWdvbl9jcHVfY2xhc3NfYnlfbmFtZShjb25zdCBjaGFyICpjcHVfbW9kZWwpCkBAIC00NzUsNiAr
NDc3LDEzOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9pbml0KE9iamVjdCAqb2JqKQogfQog
CiAjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyBib29sIGdldF9waHlzaWNhbF9hZGRy
ZXNzKENQVUhleGFnb25TdGF0ZSAqZW52LCBod2FkZHIgKnBoeXMsIGludCAqcHJvdCwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90ICpzaXplLCBpbnQzMl90ICpleGNw
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgYWRkcmVzcywKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUs
IGludCBtbXVfaWR4KQorCit7CisgICAgaWYgKGhleGFnb25fY3B1X21tdV9lbmFibGVkKGVudikp
IHsKKyAgICAgICAgcmV0dXJuIGhleF90bGJfZmluZF9tYXRjaChlbnYsIGFkZHJlc3MsIGFjY2Vz
c190eXBlLCBwaHlzLCBwcm90LCBzaXplLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGV4Y3AsIG1tdV9pZHgpOworICAgIH0gZWxzZSB7CisgICAgICAgICpwaHlzID0gYWRkcmVz
cyAmIDB4RkZGRkZGRkY7CisgICAgICAgICpwcm90ID0gUEFHRV9WQUxJRCB8IFBBR0VfUkVBRCB8
IFBBR0VfV1JJVEUgfCBQQUdFX0VYRUM7CisgICAgICAgICpzaXplID0gVEFSR0VUX1BBR0VfU0la
RTsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorfQorCisvKiBxZW11IHNlZW1zIHRvIG9u
bHkgd2FudCB0byBrbm93IGFib3V0IFRBUkdFVF9QQUdFX1NJWkUgcGFnZXMgKi8KK3N0YXRpYyB2
b2lkIGZpbmRfcWVtdV9zdWJwYWdlKHZhZGRyICphZGRyLCBod2FkZHIgKnBoeXMsIHVpbnQ2NF90
IHBhZ2Vfc2l6ZSkKK3sKKyAgICB2YWRkciBwYWdlX3N0YXJ0ID0gKmFkZHIgJiB+KCh2YWRkciko
cGFnZV9zaXplIC0gMSkpOworICAgIHZhZGRyIG9mZnNldCA9ICgoKmFkZHIgLSBwYWdlX3N0YXJ0
KSAvIFRBUkdFVF9QQUdFX1NJWkUpICogVEFSR0VUX1BBR0VfU0laRTsKKyAgICAqYWRkciA9IHBh
Z2Vfc3RhcnQgKyBvZmZzZXQ7CisgICAgKnBoeXMgKz0gb2Zmc2V0OworfQorCisKKyNkZWZpbmUg
SU5WQUxJRF9CQURWQSAweGJhZGFiYWRhCisKK3N0YXRpYyB2b2lkIHNldF9iYWR2YV9yZWdzKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBWQSwgaW50IHNsb3QsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICBNTVVBY2Nlc3NUeXBlIGFjY2Vzc190eXBlKQoreworICAgIGVudi0+dF9z
cmVnW0hFWF9TUkVHX0JBRFZBXSA9IFZBOworCisgICAgaWYgKGFjY2Vzc190eXBlID09IE1NVV9J
TlNUX0ZFVENIIHx8IHNsb3QgPT0gMCkgeworICAgICAgICBlbnYtPnRfc3JlZ1tIRVhfU1JFR19C
QURWQTBdID0gVkE7CisgICAgICAgIGVudi0+dF9zcmVnW0hFWF9TUkVHX0JBRFZBMV0gPSBJTlZB
TElEX0JBRFZBOworICAgICAgICBTRVRfU1NSX0ZJRUxEKGVudiwgU1NSX1YwLCAxKTsKKyAgICAg
ICAgU0VUX1NTUl9GSUVMRChlbnYsIFNTUl9WMSwgMCk7CisgICAgICAgIFNFVF9TU1JfRklFTEQo
ZW52LCBTU1JfQlZTLCAwKTsKKyAgICB9IGVsc2UgaWYgKHNsb3QgPT0gMSkgeworICAgICAgICBl
bnYtPnRfc3JlZ1tIRVhfU1JFR19CQURWQTBdID0gSU5WQUxJRF9CQURWQTsKKyAgICAgICAgZW52
LT50X3NyZWdbSEVYX1NSRUdfQkFEVkExXSA9IFZBOworICAgICAgICBTRVRfU1NSX0ZJRUxEKGVu
diwgU1NSX1YwLCAwKTsKKyAgICAgICAgU0VUX1NTUl9GSUVMRChlbnYsIFNTUl9WMSwgMSk7Cisg
ICAgICAgIFNFVF9TU1JfRklFTEQoZW52LCBTU1JfQlZTLCAxKTsKKyAgICB9IGVsc2UgeworICAg
ICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIH0KK30KKworc3RhdGljIHZvaWQgcmFp
c2VfdGxibWlzc19leGNlcHRpb24oQ1BVU3RhdGUgKmNzLCB1aW50MzJfdCBWQSwgaW50IHNsb3Qs
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNTVVBY2Nlc3NUeXBlIGFjY2Vz
c190eXBlKQoreworICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisKKyAg
ICBzZXRfYmFkdmFfcmVncyhlbnYsIFZBLCBzbG90LCBhY2Nlc3NfdHlwZSk7CisKKyAgICBzd2l0
Y2ggKGFjY2Vzc190eXBlKSB7CisgICAgY2FzZSBNTVVfSU5TVF9GRVRDSDoKKyAgICAgICAgY3Mt
PmV4Y2VwdGlvbl9pbmRleCA9IEhFWF9FVkVOVF9UTEJfTUlTU19YOworICAgICAgICBpZiAoKFZB
ICYgflRBUkdFVF9QQUdFX01BU0spID09IDApIHsKKyAgICAgICAgICAgIGVudi0+Y2F1c2VfY29k
ZSA9IEhFWF9DQVVTRV9UTEJNSVNTWF9DQVVTRV9ORVhUUEFHRTsKKyAgICAgICAgfSBlbHNlIHsK
KyAgICAgICAgICAgIGVudi0+Y2F1c2VfY29kZSA9IEhFWF9DQVVTRV9UTEJNSVNTWF9DQVVTRV9O
T1JNQUw7CisgICAgICAgIH0KKyAgICAgICAgYnJlYWs7CisgICAgY2FzZSBNTVVfREFUQV9MT0FE
OgorICAgICAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gSEVYX0VWRU5UX1RMQl9NSVNTX1JXOwor
ICAgICAgICBlbnYtPmNhdXNlX2NvZGUgPSBIRVhfQ0FVU0VfVExCTUlTU1JXX0NBVVNFX1JFQUQ7
CisgICAgICAgIGJyZWFrOworICAgIGNhc2UgTU1VX0RBVEFfU1RPUkU6CisgICAgICAgIGNzLT5l
eGNlcHRpb25faW5kZXggPSBIRVhfRVZFTlRfVExCX01JU1NfUlc7CisgICAgICAgIGVudi0+Y2F1
c2VfY29kZSA9IEhFWF9DQVVTRV9UTEJNSVNTUldfQ0FVU0VfV1JJVEU7CisgICAgICAgIGJyZWFr
OworICAgIH0KK30KKworc3RhdGljIHZvaWQgcmFpc2VfcGVybV9leGNlcHRpb24oQ1BVU3RhdGUg
KmNzLCB1aW50MzJfdCBWQSwgaW50IHNsb3QsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBNTVVBY2Nlc3NUeXBlIGFjY2Vzc190eXBlLCBpbnQzMl90IGV4Y3ApCit7CisgICAgQ1BV
SGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKKworICAgIHNldF9iYWR2YV9yZWdzKGVu
diwgVkEsIHNsb3QsIGFjY2Vzc190eXBlKTsKKyAgICBjcy0+ZXhjZXB0aW9uX2luZGV4ID0gZXhj
cDsKK30KKworc3RhdGljIGNvbnN0IGNoYXIgKmFjY2Vzc190eXBlX25hbWVzW10gPSB7ICJNTVVf
REFUQV9MT0FEICIsICJNTVVfREFUQV9TVE9SRSIsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIk1NVV9JTlNUX0ZFVENIIiB9OworCitzdGF0aWMgY29uc3QgY2hh
ciAqbW11X2lkeF9uYW1lc1tdID0geyAiTU1VX1VTRVJfSURYIiwgIk1NVV9HVUVTVF9JRFgiLAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIk1NVV9LRVJORUxfSURYIiB9
OworCitzdGF0aWMgYm9vbCBoZXhhZ29uX3RsYl9maWxsKENQVVN0YXRlICpjcywgdmFkZHIgYWRk
cmVzcywgaW50IHNpemUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1NVUFjY2Vzc1R5
cGUgYWNjZXNzX3R5cGUsIGludCBtbXVfaWR4LCBib29sIHByb2JlLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50cHRyX3QgcmV0YWRkcikKK3sKKyAgICBDUFVIZXhhZ29uU3RhdGUg
KmVudiA9IGNwdV9lbnYoY3MpOworICAgIGludCBzbG90ID0gMDsKKyAgICBod2FkZHIgcGh5czsK
KyAgICBpbnQgcHJvdCA9IDA7CisgICAgdWludDY0X3QgcGFnZV9zaXplID0gMDsKKyAgICBpbnQz
Ml90IGV4Y3AgPSAwOworICAgIGJvb2wgcmV0ID0gMDsKKworICAgIHFlbXVfbG9nX21hc2soCisg
ICAgICAgIENQVV9MT0dfTU1VLAorICAgICAgICAiJXM6IHRpZCA9IDB4JSIgUFJJeDMyICIsIHBj
ID0gMHglMDgiIFBSSXgzMiAiLCB2YWRkciA9IDB4JTA4IiBWQUREUl9QUkl4CisgICAgICAgICIs
IHNpemUgPSAlZCwgJXMsXHRwcm9iZSA9ICVkLCAlc1xuIiwKKyAgICAgICAgX19mdW5jX18sIGVu
di0+dGhyZWFkSWQsIGVudi0+Z3ByW0hFWF9SRUdfUENdLCBhZGRyZXNzLCBzaXplLAorICAgICAg
ICBhY2Nlc3NfdHlwZV9uYW1lc1thY2Nlc3NfdHlwZV0sIHByb2JlLCBtbXVfaWR4X25hbWVzW21t
dV9pZHhdKTsKKyAgICByZXQgPSBnZXRfcGh5c2ljYWxfYWRkcmVzcyhlbnYsICZwaHlzLCAmcHJv
dCwgJnBhZ2Vfc2l6ZSwgJmV4Y3AsIGFkZHJlc3MsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYWNjZXNzX3R5cGUsIG1tdV9pZHgpOworICAgIGlmIChyZXQpIHsKKyAgICAgICAgaWYg
KCFleGNwKSB7CisgICAgICAgICAgICBmaW5kX3FlbXVfc3VicGFnZSgmYWRkcmVzcywgJnBoeXMs
IHBhZ2Vfc2l6ZSk7CisgICAgICAgICAgICB0bGJfc2V0X3BhZ2UoY3MsIGFkZHJlc3MsIHBoeXMs
IHByb3QsIG1tdV9pZHgsIFRBUkdFVF9QQUdFX1NJWkUpOworICAgICAgICAgICAgcmV0dXJuIHJl
dDsKKyAgICAgICAgfQorICAgICAgICBpZiAocHJvYmUpIHsKKyAgICAgICAgICAgIHJldHVybiBm
YWxzZTsKKyAgICAgICAgfQorICAgICAgICByYWlzZV9wZXJtX2V4Y2VwdGlvbihjcywgYWRkcmVz
cywgc2xvdCwgYWNjZXNzX3R5cGUsIGV4Y3ApOworICAgICAgICBkb19yYWlzZV9leGNlcHRpb24o
ZW52LCBjcy0+ZXhjZXB0aW9uX2luZGV4LCBlbnYtPmdwcltIRVhfUkVHX1BDXSwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldGFkZHIpOworICAgIH0KKyAgICBpZiAocHJvYmUpIHsKKyAg
ICAgICAgcmV0dXJuIGZhbHNlOworICAgIH0KKyAgICByYWlzZV90bGJtaXNzX2V4Y2VwdGlvbihj
cywgYWRkcmVzcywgc2xvdCwgYWNjZXNzX3R5cGUpOworICAgIGRvX3JhaXNlX2V4Y2VwdGlvbihl
bnYsIGNzLT5leGNlcHRpb25faW5kZXgsIGVudi0+Z3ByW0hFWF9SRUdfUENdLCByZXRhZGRyKTsK
K30KIAogc3RhdGljIGJvb2wgaGV4YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNz
LCBpbnQgaW50ZXJydXB0X3JlcXVlc3QpCiB7CkBAIC01MTcsNiArNjUxLDcgQEAgc3RhdGljIGNv
bnN0IFRDR0NQVU9wcyBoZXhhZ29uX3RjZ19vcHMgPSB7CiAgICAgLmNwdV9leGVjX2ludGVycnVw
dCA9IGhleGFnb25fY3B1X2V4ZWNfaW50ZXJydXB0LAogICAgIC5wb2ludGVyX3dyYXAgPSBoZXhh
Z29uX3BvaW50ZXJfd3JhcCwKICAgICAuY3B1X2V4ZWNfcmVzZXQgPSBjcHVfcmVzZXQsCisgICAg
LnRsYl9maWxsID0gaGV4YWdvbl90bGJfZmlsbCwKICNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05M
WSAqLwogfTsKIAotLSAKMi4zNC4xCgo=

