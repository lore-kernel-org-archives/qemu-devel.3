Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20361606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HcN+cwQc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=duWZOEda
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8Yd-0002sg-8O; Thu, 19 Nov 2026 15:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YJ-0002la-3T
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:15 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xU8YG-0000qN-IW
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:16:14 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Xvr095604
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=; b=HcN+cwQcpiAMAxVj
 SE0y2rc88hne/IVt3ORnvqWHCn2UIeH25YDR6Jp95ZpkWyagPVssB1CJjLpBxYWN
 qIIr8Qu9ev5G8fu+eejaSIhE5OmA4UHsA96nYw8ap4NeZu9kt2misgGmZQYXRgYn
 9NuUY8khK2ERStKeFAsfS1nhzhbEs/MTe5JvJN25dLLn4IGKJWc14RIfR/YGczV4
 0xkMRDS6c9jr8YfJRo7Uc7ErhcVJxCCr+Arnx6U3La19X9WVnjVqb/CY333Zbwcx
 oeo4DwToPVFv77P1djUyTOq7iqxQ7ZNPWP6BHfdqYlycrH9vF4GMOsaky13oL8EW
 RVHqHQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx1ayb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:16:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3837afac185so285052eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795119370; x=1795724170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=;
 b=duWZOEdaeIMOKJc6UII/ucrpmo5Ktczvzu+/EiuSCJHSjsPDBvcf6uzUscoJEH5/k8
 YZ1k1sWIotP122Ly7EsQhl1hGlQu8yKD7VHhPenyDK69foJAu44UzE0SqlPYxUWN10Iz
 AX7WlJe4C+sdvXy/XALiIJck+Hj7L21N8kKMUKiNLFh6B3JFQqHYId1RXgqZ8p+uryKo
 L5m0VQqYAJ81kLWjZ/jYITJLcSYa+lW/SwtvqKnOqGSo5Sn+SxQu7qM52Md058P260lh
 S8076FGvdTzKHNTYH/0rQLScWW+8i0cztNxT7IipLDKC+bkzS4X5R6molukGhA536VlR
 78tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795119370; x=1795724170;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MkvDrOWSlGvBHbNR9evveCnWRkHoN3V/Q+Y5xcXdxuc=;
 b=Ce0ftlD5lqve7qtS47C+PB8E9Y4eWVnY8s5ciZoM/s59C375avA4X9o20pUcvP6WkY
 29lBJwxhz/OTtTe01fDby06zTaNqeBP/HWCKl30/UaacSh1hhspbSuGaFVdYcRgx2k2P
 m2iJEWlRA7gF5y2k6ckYJWM1SJQQzfOazXN8+5XXLIg4gWDpyajIVM91BBV+t8wyes12
 ePlNIbNLf5P8vECLl57ThaHoSozsu8742YIWIaVDrNqE5cFm5VAXrUPlfJyeuNhIx82T
 kpOYWzctm4uieNMFQuOfmLcBLr7FFViF/fOLOrqlVxJuG/psQOLRrAVCKLkVwotXPAmf
 vTaw==
X-Gm-Message-State: APuU4Z9wB11fvF0gmfuTxAj02wE/ZkSwccdNvewuWH7XzkSO3I2NsiIB
 jD3VsU9qnkVTUdsKBL+bbNvNCwCiDVR5azT8W7NGQ1MxafpuI295qvKXlsT1mMTKcjS/JPG6LUe
 QwRv4xQAAY9o5kt04pZ4SnhzGC2hb1Xu7RG86VadY4uCpKFIRuHwwFfVrFoCVxSq9HA==
X-Gm-Gg: AZFdTZdtBanLqd8R1XwaIfv+w9cUnhj0IgpdN3QVMWZQrOP4vdpO5UC8VDyvUbB6Vhp
 lOfQzuLh5fmXBOYFBANBx0u31PAX37Y9IDJ2gfGZ+oq5n0A8lAxV86lgNGMHVD0Otdw3xbgc/kf
 qfPXMvzQKxtptY5+x/1UBDN7pynSkxy9tDLv72yFnollLbHfU+mgcotovC9DzeYYvAl4/BldWwV
 mFRdT3pfQ2xOJUtlR8XY744u17WzbcF7T91Z0uN2mxkqLABihEblDGlxzT2X4usl7JWqvLq/TxE
 HbUrdAInrbxGDBfcgMpBeuHcvQtIOWcF0tBMTZObrPcVtcb9W6il75mvZhlUjQKlmi2A7vUQe0e
 pzkCE5ztYdEh11FhiSkdpFCGGQ7tTjNzqayo/zEBFbl9PZWKg1svdTxY7Cn/UDKPfph5R9gyB09
 E5qKT8Y8+/utkO4IQlmCGBlQ==
X-Received: by 2002:a05:693c:41cb:10b0:36a:7bb7:4609 with SMTP id
 5a478bee46e88-3856f65cb00mr455005eec.34.1795119369875; 
 Thu, 19 Nov 2026 12:16:09 -0800 (PST)
X-Received: by 2002:a05:693c:41cb:10b0:36a:7bb7:4609 with SMTP id
 5a478bee46e88-3856f65cb00mr454978eec.34.1795119369397; 
 Thu, 19 Nov 2026 12:16:09 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385616f0a3fsm1132085eec.0.2026.11.19.12.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 12:16:08 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-11.2 03/14] target/hexagon: fix get_exe_mode assertion in
 hexagon_stop_thread
Date: Thu, 19 Nov 2026 12:15:52 -0800
Message-Id: <20261119201603.2377989-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
References: <20261119201603.2377989-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6aff590a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=DyE358pAE-X188sEe20A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: UPkA1cNtbpltGIHcnigOAkP_ukAjMWtQ
X-Proofpoint-GUID: UPkA1cNtbpltGIHcnigOAkP_ukAjMWtQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX7x6UbiXhtDQ6
 Ht38Pcu25P2Oo1AiRSfhmBpW+QBoxs7JbxxvEAoGGU0nMUP5kHTootRtUBs0bGDkBjEoNH41wmx
 KrYWi2e6AVvWbtAGsNshX7NjgwirIzTpYONZzlImIl4muw5VCVe+aQShjs2YzSUbPRMhhRvpfV2
 ayEXgn69mNOZzRJ9knSvny90Kzfxs1WOSAQs8UBEVyzUY4UUpGjF4wgGogJxDr0+rpy+biWQWSi
 RRPCPDp+oCARqsDcj2iMnyCXfUtEc83OO/MaDqI1iHZXcyQK18jXLVRk6krif3Nj4ZHZpJgElVl
 93MDtEAfUq/Tm0LNZIQNXTXFVDMHW68+zKVHO3e1jG2KJuVQQVGrS36OYDS6MkarnC3OBqzwdUP
 Eg6l0HDHk/lZYkVOsyKOvVtqCs3gX9R5ovYXkfu3ScDNFWOD2n4HHzYxB5zIShpjEUhj+8lghV+
 0c3BU1HhTg/3KIBGGGg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MCBTYWx0ZWRfX8AGY5VLQRsQt
 ESwf+CJQeB1JcfgNaFpSkQP4NOMyThubefOz/GvJltVjSxNcuvAy4h7TqqnlJvMqk+tJsf4RRjX
 T8BmHVbfKjDD858i1U6V4vpIwVO8m3s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190080
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

V2hlbiBhIHRocmVhZCBpbiBXQUlUIG1vZGUgKFc9MSwgRT0xKSBleGVjdXRlcyBhIFNUT1AgaW5z
dHJ1Y3Rpb24sCmhleGFnb25fc3RvcF90aHJlYWQgbXVzdCBjbGVhciB0aGUgd2FpdC1tb2RlIGJp
dCBiZWZvcmUgY2xlYXJpbmcKdGhlIGVuYWJsZSBiaXQuICBXaXRob3V0IHRoaXMsIGNsZWFyX2Vu
YWJsZV9tYXNrIGNyZWF0ZXMgYSB0cmFuc2llbnQKKFc9MSwgRT0wKSBzdGF0ZSBpbiBNT0RFQ1RM
IHRoYXQgdHJpZ2dlcnMgZ19hc3NlcnRfbm90X3JlYWNoZWQoKSBpbgpnZXRfZXhlX21vZGUoKSB3
aGVuIGFub3RoZXIgdGhyZWFkIGl0ZXJhdGVzIGFsbCBDUFVzIHZpYQpoZXhfaW50ZXJydXB0X3Vw
ZGF0ZS4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAxICsKIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYwppbmRleCBmNTNkMzc3YWIxNC4uNjgw
ZGNmNTY4MDMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMKQEAgLTQ0MSw2ICs0NDEsNyBAQCB2b2lkIGhleGFn
b25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAKICAgICBCUUxfTE9DS19HVUFS
RCgpOwogCisgICAgY2xlYXJfd2FpdF9tb2RlKGVudik7CiAgICAgdGhyZWFkX2VuYWJsZWRfbWFz
ayA9IGNsZWFyX2VuYWJsZV9tYXNrKGVudik7CiAgICAgY3MgPSBlbnZfY3B1KGVudik7CiAgICAg
Y3B1X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9IQUxUKTsKLS0gCjIuMzQuMQoK

