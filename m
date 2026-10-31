Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C6606A31E
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=llXVKVyC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KS9XGCjg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxwd-0006Nf-CA; Fri, 30 Oct 2026 21:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxwB-0005On-5f
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxw8-00038Y-QE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:31:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1ChXx759224
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PoGeBMLBkWf8sGEDsZ2jWyQtT7QpdhGFc4n6CAKvs4Q=; b=llXVKVyCUh9mfpbQ
 nSA4Ym/8nYbD9rBRu1il2yl9iSCSnDc6pDruglHLd+LMbkoxrgwiJc5j2rynh3dF
 zou8ty0JlV90HeNXYxqj/6JOD9uIvIhluUIwWOMBPDnaBJ4p9R5dlqmumGhnlf++
 JG5g//rQTjsUz/tgI+QP+1XENofWczJIkHdxQ2GJ/kxI8sCz05GW1zw72bOXBNhp
 RVHbZ2TOxm8gDuwcLIHnmKZGs/tzxiv/PWPLlr4vdOHbvbUQ4/jR7DUZK4mGsOe9
 3+RqnNj875Sx99fPoQhzb6N6obWZ1obua85LW5DMnbkJ3AYpk5gXr29mYovaXHkS
 WKwg0g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkg4cw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:31:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so2461732eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410261; x=1794015061; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PoGeBMLBkWf8sGEDsZ2jWyQtT7QpdhGFc4n6CAKvs4Q=;
 b=KS9XGCjgo2YWh1BrUw5xjTd+zrAz+MTufONEDOVxsQVJm6QXqy7+FF0cANcUP8tnlB
 1bvcTZYs4R6oxhb5iz6pm2yvhKLiYXlTgg4zA7mEOTeuhSGPZXkufG3zNzrJPGSJU+wM
 5yxJ/8odiDTVXkmT22bWmiBskO1hHQvjyVM9koARDf0jLUmlEiKS81EX2A25ZwFx5Iqk
 gZBVBtIG5P5ZO3SYat8+3I8lFqmHZNnUXgSKntX7BviaOa6wIAeSbf6Ix3VO+x3yiZ71
 0LMUKvm2OCsV8rPYKj+KsrnlgeXYM8B5CnGYR8t5g070xj4w+GpAwYSoiwSVQIFGaTG9
 Y4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410261; x=1794015061;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PoGeBMLBkWf8sGEDsZ2jWyQtT7QpdhGFc4n6CAKvs4Q=;
 b=EqQJ6wuQO3v73gLGH68SmtrjmPTQVFtKPj011ZmPXyqg2oGsS4zqIKRR8a/Tt07Dra
 rNIMBbmP7p8AMHrfQbN/L5tFHT2IeVKPjTdqKGaaT12UoOe3FVG8PXTZ9MXrrRamFbmO
 6ev44jjkaVOTFnwi30SwK+d40RuUAOCWMezrpDlvmFji5TJp/6HkaT6NSIjaZv/uvmeE
 Y3ltq0m5iOQsYecwsBePRowVwENQxNlxrvK0nfnusHYpr9zDGUXKyE4tV5DHZq5fPBXN
 lBj6a8Y12VyBvt1yZOYsg3SPBtXOsYLKnuPMAUdwKLM638NLH5IBxwaGvZLRCL/zoNBo
 WZng==
X-Gm-Message-State: AFq9FYLXpNLwF/gn//3mgoDrEE+rWTZHbb1CEzPQolnY+2RgKygRIqFy
 IcM1VaijLBa7joRFneIAOqxAYuXgCJWxFvcigRBmAORcHcFSSkvIt2onYY2TomkO247dgon2w3d
 pFerkVvYoynv3hFATRseKdkFbwj9DwnrdqbIy5eUdjkgt1GQfq13NfjIFAhyvmr+oIQ==
X-Gm-Gg: AYBFou3LT4fEL9gPuixHn9DoQNXH8GZxzNV7d34TJOk47yOK29KwWx9FAAsCdubryf9
 KhPGH+6C54I8BKuwuPAsX49kB37E5LgAEXeCXyRaoOxAVDvJirjZ1WZeX91L8UTuj70tE9cqkz2
 yGZDI4MENfw2MWkKEnIJ2KKexymPmMC6WmTGbnLQOsJyaTzj0NH0st+/aFNrLElhGdptidXV6T9
 VBegg/0WlfcqsHQi5x4RGkFr9SJdCk9Eb+WhLh6kYFB0V1/cH1JLMi5eNg046IeCL5O+3yxqJK/
 TBVzpauBj7+nJrskbcwsciHYptpSz6uO8JQOZuyzToNfd7+pQW9fs5SIgfBYMVF161z9/lXzJPT
 MOS+9+5RgmBLIXDyu2C7Glx+E8v32w+WD6NRrbnoU+BG9hkO6uvM6cCPS8+Dnxbm9kN39l6JsNd
 sAzUjgKxvP/5g2TX+OPO6ufw==
X-Received: by 2002:a05:7300:c8c2:b0:36a:117:522a with SMTP id
 5a478bee46e88-36a423bf71cmr5894778eec.22.1793410260579; 
 Fri, 30 Oct 2026 18:31:00 -0700 (PDT)
X-Received: by 2002:a05:7300:c8c2:b0:36a:117:522a with SMTP id
 5a478bee46e88-36a423bf71cmr5894727eec.22.1793410259976; 
 Fri, 30 Oct 2026 18:30:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:59 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 33/40] target/hexagon: add HMX attrs, state
Date: Fri, 30 Oct 2026 18:29:34 -0700
Message-Id: <20261031012941.339141-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: CJXjDrx-HFo3YKQuvIwNZT1gPKNQotS8
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae544d5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eIqSBVWmwaVrM3dqyzoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX/+qg6RbFX2DB
 mMv1/V3XGMwWQmFyyX6xfhg1JxrSv+bmrtMMtMNFkWQNqWf2aizRJNVFDHxVYjjRbbpWJKT82Na
 M5psE3pduiey1EfgHYx1HB+gqktqN1k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX87IMh+YvKYoY
 dNiZEzHAtCuvbOcrmiXEGl7O3kspkfoLiAmQIju0YGuIOQyLkpbi9+tdFF1EzwRzjXU9AQWuVJ4
 RYkubGkR8/O75T0p4rGvf0VZq7VMzE3LC9kpEhEn/ghwYSHCZbsqMcWD4OVlYpUlTIk+eug5xS1
 eILkSI2VKfoS9uEvYtsM7SJbGQvpA99ZRyAPb0bjcrK/UwriwerZzRxPHqXAC/1b91DNgnpjtG/
 /LunRGN5POQ1D7+3pBOhAUUkdnGNacisXjzsGO6q2P/riVogDwH+yUR6neZ8lqgJHgsvqoYNaGs
 vEo5VGvdKv6d5Pzbq/j+UN5TBPyO+UOWiWNvB+xbzG42tavlfGpecJkxTolRSDld3XWb4U1WaOw
 S/y5j5M3UYJ9+1vU05zosZe847s4xOd+sD33Yz8rjRgvVrHe9vnPNRn7/gqLOgx8IrMV9+3iV0e
 gutq5AZdTi5HXj5f5VA==
X-Proofpoint-ORIG-GUID: CJXjDrx-HFo3YKQuvIwNZT1gPKNQotS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310005
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

QWRkIGluc3QgYXR0cmlidXRlcyBmb3IgSE1YIGFuZCBzdGF0ZSBkZWZpbml0aW9uLgoKUmV2aWV3
ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9obXhfc3RhdGUuaCAgICAgICB8IDkyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyB8IDEyICsrKysr
CiAyIGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGFyZ2V0L2hleGFnb24vaG14X3N0YXRlLmgKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9o
bXhfc3RhdGUuaCBiL3RhcmdldC9oZXhhZ29uL2hteF9zdGF0ZS5oCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi40M2M4Y2JkOWUwNwotLS0gL2Rldi9udWxsCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hteF9zdGF0ZS5oCkBAIC0wLDAgKzEsOTIgQEAKKy8qCisgKiBIZXhhZ29u
IEhNWCAoTWF0cml4IGVYdGVuc2lvbnMpIFN0YXRlIERlZmluaXRpb25zCisgKgorICogQ29weXJp
Z2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJp
ZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisK
KyNpZm5kZWYgSEVYQUdPTl9ITVhfU1RBVEVfSAorI2RlZmluZSBIRVhBR09OX0hNWF9TVEFURV9I
CisKKyNkZWZpbmUgSE1YX1NQQVRJQUxfRElNX0ZYUCAgICAgNjQKKyNkZWZpbmUgSE1YX1NQQVRJ
QUxfRElNX0ZQICAgICAgMzIKKyNkZWZpbmUgSE1YX09VVFBVVF9DSEFOTkVMUyAgICAgMzIKKyNk
ZWZpbmUgSE1YX05VTV9BQ0NfU0VUUyAgICAgICAgMgorI2RlZmluZSBITVhfTlVNX0NWVF9BR0VT
ICAgICAgICAzCisjZGVmaW5lIEhNWF9OVU1fQklBU19TRVRTICAgICAgIDQKKworI2RlZmluZSBI
TVhfQUNUX0NST1VUT05fU0laRSAgICAyMDQ4CisjZGVmaW5lIEhNWF9BQ1RfQ0FDSEVfU0laRSAg
ICAgICgyICogSE1YX0FDVF9DUk9VVE9OX1NJWkUpCisKK3R5cGVkZWYgc3RydWN0IEhteEFjY0Z4
cCB7CisgICAgaW50MzJfdCBkYXRhW0hNWF9TUEFUSUFMX0RJTV9GWFBdW0hNWF9PVVRQVVRfQ0hB
Tk5FTFNdOworfSBIbXhBY2NGeHA7CisKKy8qIEZQIGFjY3VtdWxhdG9yIGNlbGwgc3RvcmFnZTog
SUVFRSBiaW5hcnk2NCBiaXQgcGF0dGVybnMgKi8KK3R5cGVkZWYgc3RydWN0IEhteEFjY0ZwIHsK
KyAgICB1aW50NjRfdCBkYXRhW0hNWF9TUEFUSUFMX0RJTV9GUF1bSE1YX09VVFBVVF9DSEFOTkVM
U107Cit9IEhteEFjY0ZwOworCit0eXBlZGVmIHN0cnVjdCBIbXhBY2NTZXQgeworICAgIEhteEFj
Y0Z4cCBmeHBfcHJpbWFyeTsKKyAgICBIbXhBY2NGcCAgZnBfcHJpbWFyeTsKK30gSG14QWNjU2V0
OworCit0eXBlZGVmIHN0cnVjdCBIbXhDdnRTdGF0ZUZ4cCB7CisgICAgdWludDE2X3QgZGF0YVtI
TVhfU1BBVElBTF9ESU1fRlhQXVtITVhfT1VUUFVUX0NIQU5ORUxTXTsKK30gSG14Q3Z0U3RhdGVG
eHA7CisKKy8qIEZQIGNvbnZlcnQgc2xvdDogb25lIEZQMTYgdmFsdWUsIG9yIGFuIEZQOCBieXRl
IHBlciBzcGF0aWFsIGhhbGYgKi8KK3R5cGVkZWYgc3RydWN0IEhteEN2dFN0YXRlRnAgeworICAg
IHVpbnQxNl90IGRhdGFbSE1YX1NQQVRJQUxfRElNX0ZQXVtITVhfT1VUUFVUX0NIQU5ORUxTXTsK
K30gSG14Q3Z0U3RhdGVGcDsKKwordHlwZWRlZiBzdHJ1Y3QgSG14U3RhdGUgeworICAgIEhteEFj
Y1NldCBhY2NbSE1YX05VTV9BQ0NfU0VUU107CisKKyAgICBIbXhDdnRTdGF0ZUZ4cCBjdnRfZnhw
W0hNWF9OVU1fQ1ZUX0FHRVNdOworICAgIEhteEN2dFN0YXRlRnAgIGN2dF9mcFtITVhfTlVNX0NW
VF9BR0VTXTsKKworICAgIEhteEN2dFN0YXRlRnhwIGN2dF9mdXR1cmVfZnhwOworCisgICAgdWlu
dDY0X3QgYmlhc19yYXdbSE1YX05VTV9CSUFTX1NFVFNdW0hNWF9PVVRQVVRfQ0hBTk5FTFNdOwor
CisgICAgdWludDMyX3QgY3VycmVudF9hY2Nfc2V0OworCisgICAgdWludDhfdCBhY3RfYnVmZmVy
W0hNWF9BQ1RfQ0FDSEVfU0laRV07CisKKyAgICB1aW50MzJfdCBhY3RfcnM7CisgICAgdWludDMy
X3QgYWN0X3R5cGU7CisgICAgdWludDhfdCAgaXNfZjhfb2RkOyAgICAgLyogUnNbMF06IEZQOCBh
Y3RpdmF0aW9uIHJlYWRzIG9kZCBieXRlIG9mIHBhaXIgKi8KKyAgICB1aW50OF90ICBmcDhfb2Rk
X3NlbDsgICAvKiBjdnQgUnNbMTFdOiBGUDggY29udmVydCB3cml0ZXMgb2RkICgxKSBoYWxmICov
CisKKyAgICB1aW50MzJfdCBmb3JtYXRfb2Zmc2V0OyAgICAgLyogU009MiwgRE09MCAqLworICAg
IHVpbnQzMl90IHRpbGVfeF9tYXNrOworICAgIHVpbnQzMl90IHRpbGVfeV9tYXNrOworICAgIHVp
bnQzMl90IHRpbGVfeF9pbmM7CisgICAgdWludDMyX3QgdGlsZV95X2luYzsKKyAgICB1aW50MzJf
dCBmeDsKKyAgICB1aW50MzJfdCBmeTsKKyAgICBpbnQzMl90ICBjaF9zdGFydDsgICAgICAgICAg
LyogcHJlLWNvbXB1dGVkIGNoYW5uZWwgc3RhcnQgKHJhdykgKi8KKyAgICBpbnQzMl90ICBjaF9z
dG9wOyAgICAgICAgICAgLyogcHJlLWNvbXB1dGVkIGNoYW5uZWwgc3RvcCAoZXhjbHVzaXZlKSAq
LworICAgIHVpbnQzMl90IHlfc3RhcnQ7CisgICAgdWludDMyX3QgeV9zdG9wOworICAgIHVpbnQz
Ml90IHlfZGlsYXRlOworICAgIHVpbnQzMl90IGJsb2NrczsKKyAgICBpbnQzMl90ICBkWTsgICAg
ICAgICAgICAgICAgLyogb2Zmc2V0IHRvIHNlY29uZCBhY3RpdmF0aW9uIGNyb3V0b24gKi8KKyAg
ICB1aW50MzJfdCBncm91cF9jb252OyAgICAgICAgLyogY2hfc3RhcnQgPiBjaF9zdG9wICovCisg
ICAgdWludDMyX3QgZ3JvdXBfc2l6ZTsKKyAgICB1aW50MzJfdCBncm91cF9jb3VudDsKKworICAg
IGludDMyX3QgIG1hY19jeWNsZV9saW1pdDsKKworICAgIC8qIERlZmVycmVkIENWVCBwaXBlbGlu
ZSBjb21taXQsIGF0IHRoZSBuZXh0IGNvbnN1bWVyIG9yIGVuZCBvZiBwYWNrZXQgKi8KKyAgICB1
aW50MzJfdCBjdnRfZnhwX3BlbmRpbmc7ICAgICAgLyogMSA9IGZ1dHVyZSBoYXMgdW5jb21taXR0
ZWQgZGF0YSAqLworICAgIHVpbnQzMl90IGN2dF9meHBfcGVuZGluZ19hZ2U7ICAvKiAxID0gcGlw
ZWxpbmUgc2hvdWxkIGFnZSBhdCBjb21taXQgKi8KKworICAgIC8qIERlZmVycmVkIGFjY3VtdWxh
dG9yIGNsZWFyL2ZsaXAsIGF0IHBhY2tldCBlbmQgb3IgbmV4dCBhY2N1bXVsYXRvciB1c2UgKi8K
KyAgICB1aW50MzJfdCBjdnRfYWNjX2NsZWFyX3BlbmRpbmc7CisgICAgdWludDMyX3QgY3Z0X2Fj
Y19jbGVhcl9zZXQ7Cit9IEhteFN0YXRlOworCisjZW5kaWYgLyogSEVYQUdPTl9ITVhfU1RBVEVf
SCAqLwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMgYi90YXJn
ZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYwppbmRleCBhYzY0NGQ1MWM4MC4uNzFjNmYwNDkx
MmEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCkBAIC0yMzMsNiArMjMzLDE4IEBAIERFRl9B
VFRSSUIoQ1ZJX1ZYX05PX1RNUF9MRCwgIkhWWCBtdWx0aXBseSB3aXRob3V0IHRtcCBsb2FkIiwg
IiIsICIiKQogREVGX0FUVFJJQihIVlhfRkxULCAiVGhpcyBhIGZsb2F0aW5nIHBvaW50IEhWWCBp
bnN0cnVjdGlvbi4iLCAiIiwgIiIpCiAKIERFRl9BVFRSSUIoTk9fSURFRl9QQVJTRVIsICJTa2lw
IGlkZWYtcGFyc2VyIGZvciB0aGlzIGluc3RydWN0aW9uIiwgIiIsICIiKQorREVGX0FUVFJJQihT
SEFSRURfRVhURU5TSU9OLCAiU2hhcmVkIGV4dGVuc2lvbiBpbnN0cnVjdGlvbiIsICIiLCAiIikK
K0RFRl9BVFRSSUIoRUFfUkVHX09OTFksICJFQSA9IGlucHV0IHJlZ2lzdGVyIG9ubHkiLCAiIiwg
IiIpCitERUZfQVRUUklCKEVBX1BBR0VDUk9TUywgIkVBIGNhbGN1bGF0aW9uIGNhbiBoYXZlIGEg
UGFnZSBDcm9zcyBTdGFsbCIsICIiLCAiIikKK0RFRl9BVFRSSUIoTVBZLCAiSGFzIGEgbXVsdGlw
bHkiLCAiIiwgIiIpCitERUZfQVRUUklCKFBBSVJfMU9GMiwgIkZvciBhc3NlbWJsZXIiLCAiIiwg
IiIpCitERUZfQVRUUklCKFBBSVJfMk9GMiwgIkZvciBhc3NlbWJsZXIiLCAiIiwgIiIpCitERUZf
QVRUUklCKEhNWCwgIkhNWCBjb3Byb2Nlc3NvciBpbnN0cnVjdGlvbiIsICIiLCAiIikKK0RFRl9B
VFRSSUIoSE1YX0NWVCwgIkhNWCBjb252ZXJ0IGluc3RydWN0aW9uIiwgIiIsICIiKQorREVGX0FU
VFJJQihITVhfRkxULCAiSE1YIGZsb2F0aW5nLXBvaW50IGluc3RydWN0aW9uIiwgIiIsICIiKQor
REVGX0FUVFJJQihITVhfQ1VfU0NBTEFSLCAiSE1YIHNjYWxhciBvcGVyYW5kIiwgIiIsICIiKQor
REVGX0FUVFJJQihITVhfQkxPQ0tfQUxJR04sICJITVggYmxvY2stYWxpZ25lZCBhY2Nlc3MiLCAi
IiwgIiIpCitERUZfQVRUUklCKEhNWF8xMjhCX0FMSUdOLCAiSE1YIDEyOC1ieXRlIGFsaWduZWQg
YWNjZXNzIiwgIiIsICIiKQogCiAvKiBLZWVwIHRoaXMgYXMgdGhlIGxhc3QgYXR0cmlidXRlOiAq
LwogREVGX0FUVFJJQihaWl9MQVNUQVRUUklCLCAiTGFzdCBhdHRyaWJ1dGUgaW4gdGhlIGZpbGUi
LCAiIiwgIiIpCi0tIAoyLjM0LjEKCg==

