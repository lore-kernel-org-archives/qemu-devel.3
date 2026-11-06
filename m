Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B6606A335
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cly3l/a/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Kf2dpRwd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPTCR-0002E1-Mv; Fri, 06 Nov 2026 18:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPTCN-0002Dk-Ds
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 18:18:20 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPTCL-0006pF-QO
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 18:18:19 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mo0Xc2144032
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 23:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gZSEzjhIz2pIXXYvyapKgtlAW6r88qrtzDVNiidWb80=; b=cly3l/a/LAq/yfee
 OdKNxdyZDFlvrJRoh4Id4dET1d1PEcXHdajAIKskcUp8DYNOErYmMvO+sMBNKFK3
 Teirp8XMyVNhy2B8QCiyBMvKwTw2a4tWOjxa2o4Kc5JVA8r0hp7Qjo40bsDnUbzC
 +vLDAwGrX9/tzeQBkeGtFwp+MXIy78zAz/gH5gdubIQhDXwiHAj7yl2ZZKfZf102
 xB0qd05bqP1m2CG6isRWlqsfMRUq9WBqQ6ZhRRSuFxhjn/IUR9z1KSuYAf4qp4Jo
 /FwZhsNhkTf90pZJS2ZezB0emsYjGURJRINWOOTpijOjGxtBg5t0fL6sZe6Do5MF
 vhTsCw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmypgrtx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 23:18:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36cec75d8caso204448eec.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 15:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007095; x=1794611895; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gZSEzjhIz2pIXXYvyapKgtlAW6r88qrtzDVNiidWb80=;
 b=Kf2dpRwdZk8rOLWZECcvz3nA0HgLND20IgodME2zbn2uEK4sUxzsZ6gvOrJz4N2+3m
 x6nnfLpVVElSEVCCL/f4F4D6qTPfEHkGHe0OjI8BzJN+E4vKJw/G88whDv0rVNpiwkIp
 apAbqYd6QzIhoyJ/b3tzyUNmbX1gNapIFaWJ4vuFcZ0TvPrgCsDYr78dl3MyMps4apjI
 6CeeDeJWMFcC+naHWy9MdND0SRk9yq8V7iroHS58IZqAnAxDAIP40btoHOXSgVFixNH4
 DkSwOt0rPJTqKNjJCtqtcCB+9pdAJiFyEpzA9JhSjilfFobwCBCTCQX0YFsKuwiPkN/i
 9IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007095; x=1794611895;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gZSEzjhIz2pIXXYvyapKgtlAW6r88qrtzDVNiidWb80=;
 b=O8t21gzl4fPF7X6bEgeVlJ1LpfZV0DkD3kSKM4+lJ1byViXpvUgFtRSJX2LC2nVqdM
 ZtggDYxjrcvxCApXF9dIV057cEf40GoxwnOmGlGaraouLLNy1xU3Ox9+ZqkYxyV/1vkA
 XM1kxgSp2asofiMjR615oP7lOih3+JOqqxJC1OiFsAb0bXaLWib8M1sYkqd998sDBDSK
 f8jukg2TjrGfcZ07ZNO0GbZTkP+lUkvdrFrsIOqHFkPSlff1SMcCbmYHAF1YbH+czkMD
 2E99vLLgWFiETxURkmo2SkDBwBcrYcgbdHIiEgGSk8OaCD2vaVf+ee2DBdUmEqZCnhmH
 goMg==
X-Gm-Message-State: APuU4Z8FMiHO3sNm/uynEvvCdKvtH2ZKK6b5SBwWtJoDoTuZr5HgOYzO
 i+T4xHD0Tfox3RSVCy/mK1+FiUh7czf9wRiZrTm7sP4ZBDVJnHYgrn3YRRQMDH9Ah3928vAvK1g
 S3SA9W1v93Tu7k1EaY9gKXNIc8yKvFTwPR+y2Q+XMa23TWm3IJrOiNK+xH2BARMyeXA==
X-Gm-Gg: AYBFou1MicgLSRdOZMPEje4tEM4YRmCXS9fPj4hj5X+eUuBZtYPtUhIKkl58KPMjITs
 UIozftjzueqMbbsFIqma8BczxaAdTT0/8uwKoiAGVSLAFkHqEUPjca99AobO1fpieMVopT5XBIk
 JmftJ5ejMVjJxCAGUAN1I8wSvEEF14iYuBf7m9xTzgzUVMBBQ1UqY3y6FDuMhiDaVrKP35rnPer
 skf4beoQOb5/WDFV/MLkU4AKoZHyOU639AJheRJLW87y2+ePU3o3KG05p2BDAxk18ynYoVuNDfh
 z9OVSSikd1eoft6lTP11tT21B7kEOIi5FJ0Lm66BCEtqswB16Q4zveGxTCFjafL5Ueycs9bmxNy
 k+bRwtI5ncD8AJpWtPLZW92TeLpE8LA6THiqHryaGOURBXNtdJhAR2fkpH0a36yG1gOZTv3wrem
 At7sutq8mqb1ATu8IWz57x/K5TeOQ4F3wVxbd6mWg0zg==
X-Received: by 2002:a05:7301:4b0d:b0:36d:bcd7:2347 with SMTP id
 5a478bee46e88-370f6115d79mr635538eec.4.1794007094400; 
 Fri, 06 Nov 2026 15:18:14 -0800 (PST)
X-Received: by 2002:a05:7301:4b0d:b0:36d:bcd7:2347 with SMTP id
 5a478bee46e88-370f6115d79mr635497eec.4.1794007093501; 
 Fri, 06 Nov 2026 15:18:13 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa651c57asm10206596eec.2.2026.11.06.15.18.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 15:18:12 -0800 (PST)
Message-ID: <5b801d11-9964-44d9-8852-380ade12e710@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 15:18:11 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] multi-target: restrict whpx-accel-*-cpu to matching
 target
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MiBTYWx0ZWRfXwCXlbAg1YG91
 NkVno2+ENuB2XgugvWOrLwfxukA8EeSfcrwLvsmtahEPo76TrT+VEkTboZod3ZyLFiBa8HneHi0
 Rgee4ik08tdDFznS11tJG08q8NmCCxagF+t+7ecbNIpDhGYjzu6+GlnErXNaWSXCGOLT3IaJh+X
 pxjH2G+WdPmcasPgsVWgL0yKrSNK2E7VaDIXYmgcVpg44je+QYezpk+bdm5g+OdcPSwJO8VMagr
 PCDw+eFIm7weh7Yh6h11V14Uzxo6RC+4EoJHAoAoHDrhxBz3UIXBph+/H0XFq4PWXfZ5wwG8iJn
 NDL9VUt/PfFtBfp8/y1qwj37vWz3PqHe6hudI2GzmAxdW6U1GPjsCfjhugRg/cG5RLRu8IrHEZM
 DklHoCjC4nAb6XD6ygmkQaDpE4ZS1SWk8VkYgR5+KoLn/Sm8CJ3PLj8/8qX2zyIL9KsuvEAVN4u
 ACxqYCzVGHhGO9nrH+Q==
X-Proofpoint-GUID: lxCQ-B7LM4dP6wG_RTVq2Y3x6n95S5L0
X-Proofpoint-ORIG-GUID: lxCQ-B7LM4dP6wG_RTVq2Y3x6n95S5L0
X-Authority-Analysis: v=2.4 cv=TZ4DJhQh c=1 sm=1 tr=0 ts=6aee6037 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=6_FdGM1TF6S1AViOgYwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MiBTYWx0ZWRfX4tUbt+T+1nk4
 Kdu7h9MqKzvCmVok9HDTMtRyCGccRMjR3T45dfljZSWhZCcOrAV57BrNkjZP7tN7/2yg41SgO7v
 8xCz7PmlKyBob22he/w8v9MFMjwxDko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060092
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 9:53 AM, Pierrick Bouvier wrote:
> On windows x64 host:
> $ ./build/tests/unit/test-multi-target
> Type 'whpx-accel-x86_64-cpu' is missing its parent 'accel-x86_64-cpu'
> (same for windows-arm64 hosts and whpx-accel-aarch64-cpu)
> 
> Parent type is conditionally registered from current target:
> register_accel_target_type uses '"accel-" + target_cpu_type()' as type
> name. Since whpx-common.c is shared between arm and x86_64 targets,
> only register whpx accelerator cpu type when current target cpu type
> matches the one it was compiled for.
> 
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  accel/whpx/whpx-common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

This was merged into master (71f25c75417d31c214ba2cd26b273c114fc99987).

Regards,
Pierrick

