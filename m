Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D3CC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 16:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwN3i-0005gU-02; Tue, 18 Aug 2026 12:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwN3g-0005g7-JE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 12:53:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwN3e-00028U-SN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 12:53:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE0inv1018155
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 15oSG5RydbZ9Kuh5v9jbMYmWTpnO2a1WqtLbHoqNBq8=; b=Z+r1Vv61tvr3ONcI
 fOlx6/9cfO03rHJw4lsoefcu8rywLbYNRUx0bUVJV/85tS3FIXRnDcJgYLodxBE8
 h6HCThIYnuzYNwdqmVRXL1vpomdie0fD+yv+mJxIyZJqapnQzO1XiBeYN+hZTX9g
 DMKLs7PwHKKcRVhXV/8+4WvdkmcvxiKUcduRMgl7btTtLb1cHBVd6XaNhtxA0Qsw
 df4c2qaC7MkxogcIVjvtI6eDWfdFyjPP3hTrzd2INqcvhKpEXKyMF7XW2S4be8Cu
 sVZaQpseT+9+1qu1kVl5CcC+3TJ4fjoFRAJuoGyEiTTxfhSylnRANAnOPDZitKKv
 FeyPtw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj16md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:53:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so205236a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787071979; x=1787676779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=15oSG5RydbZ9Kuh5v9jbMYmWTpnO2a1WqtLbHoqNBq8=;
 b=PA2tZmxlYsT3VTkq2Rtp1h9Hn2AhxbW7v0x/RgRXdSe8ivD9ThoKNQTzNhw+xW7eW3
 UfhHOJqsvnuZvVmhaEH7kzzjGiQ534ecPVWomHMFLLPvGaY0xqq7d+sItFBAlS3jcQUN
 4UTeFx9kZoyCS3XmnprMV7ZGlv73+wiP0VLieRUPOhXcuO60lmkvG0ggTlFzbYkG5Skw
 512mbqs1VlEs3wLnFeX0hqHUxVqEtk50r3n7h6MHkab1O3IApb2XbUFgZT0Zlo3Ws/aL
 9fqdSVMGUIM0I0F/pwgz5L482Gst4tYEcdt53Sxye6Se3oiP2Jacoj0DMxZLnzOlA84W
 6PSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787071979; x=1787676779;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=15oSG5RydbZ9Kuh5v9jbMYmWTpnO2a1WqtLbHoqNBq8=;
 b=N9iBbZIi2gsRKlMiKTx3VjbmdLxAF06Pm2wUK2ZoX5uAb7Fh5l0I6KPMWaytf24H+R
 TVIp8XbKy7wda+ZhUtpHY0WaODCG6IPYfQaiLYAHaasXsi4aS1OTWgZBNpxHyK8Pgh9J
 fPsNuOqrvT2LiDlEETcQrAef7y/QUA8gtek+lGjyfA/UUnP4OaIVGRcDNy8xMdBJPZ3U
 5WI+XabZgGnbqIqzvFZQZScp+MXxgocidkBI5jgMOox2vmncTHOlOQFGnTYTajmbtA22
 CIww3bBRd80oKfI7UiIab1jQJtXxoECFdMIWig0nquGUXezpD1U7UqPxNiY5DJDxOqnd
 BGqA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNCsOCl/1B8GMAQIZ7AdHzLTgNyqoirVONk7sYzqQBbTc4firJGkqe9/FW33h8kNmU+D1m+MIwNVsi@nongnu.org
X-Gm-Message-State: AOJu0Yz1SzD7zfNxGJCkL/DLpc2kTRxdzvJpyCn9ucO/YIITnc7XyGbt
 kbfo6g9G/urlLOvplw9Mnop/K44IvjvNfd7wS1fR/cxO2pVGI4rS1NtXe2s1YQemWqc0S8DY6PH
 wARauCx4fS1mm6oTdeHNcza2ESzHqRtlJUgcfIMDxjxtvqhJlO4Go8cnC8w==
X-Gm-Gg: AR+sD11Y2nxVSx1ry/zhxt7wsfcDn8ceaL0llR51off7WMz/L2KHdX0aRFBnfH6bRv9
 iRBG6BuaRNG2AJuYrprV7qGrwcngV3xNVaeHVHMiWJ++bBdAuOAVx0mTg/R8J9xvBnw9Du7N2+w
 hDiofYsMdTn0TJX/KmFZaIJzsg9Z0Ly3oCgbEhX/Io27+a6aFTNUlR2S08zwelm82Q4smTSBq/N
 kD3SFwVd19pzCaFEzisET+PDmBBjXZJ2kDrJAqQGmo1dtOCK7CyU+JCx6VNS04bxuqgEsneJ7Ag
 ZRZUDZUtrnkgfQsaBDCBTGF2EfrOVPO5+kX+85Q+l7hLWQBk6ortF8xEdrLEydpwB+hyGe3/5Fd
 zAr6LanTiBnRM1j0zQgDVgHLikcppH+DR+GMwWvpxHDP87LL1RZ40+MK7BHYW1GZT1vAG
X-Received: by 2002:a17:90b:554d:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-3955a7b15e0mr13074572a91.11.1787071979273; 
 Tue, 18 Aug 2026 09:52:59 -0700 (PDT)
X-Received: by 2002:a17:90b:554d:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-3955a7b15e0mr13074490a91.11.1787071978685; 
 Tue, 18 Aug 2026 09:52:58 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c389363sm18862621eec.23.2026.08.18.09.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 09:52:57 -0700 (PDT)
Message-ID: <e3aac1e2-6caf-4f18-9201-f3ba320c692a@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 09:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] RME-DA preparatory work
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNCBTYWx0ZWRfX4C3yAI8MHRVX
 tr2zuF3EHKPIeLoVCBzMpkZRSCI1UeCYPRwyREEi8g1yP23zs3/3V08v9PLLe4ibKqYenL4R3dK
 9Pk4486Q+qvCRkB+97+qdQeH6yjtVMU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNCBTYWx0ZWRfX4+3XXFTVct9Q
 1DVUT8Proe+LRm/7iwreBn0KarsMpnVjV0cBnwUGdL0hwvlI/T11gaTV+qoQiyofGcxBboRmuFz
 qGO5FjhqeSLiIv3bSbzYBcpyqZXwwRh0ORBvglx8ER1YqhuAetRM2uuKYtd711OelsuIMb+xnlx
 ka+WehxQ07wbMYqhMCvpdSCxsmktBPOVsgWJv5x6xyBoPyoCF0eh1SLYujkpckmE4gyhHQzRzEb
 kSeW8oZSF6ZZxQNyBeOpu9m34v3y8rJLeWwItMTB1tn1Cllt2WyLLFA9zNK9B1PgmCRVfY0uZz6
 0607zBqmZyh8HanmHqT3Z05VvPQmWEerWir8L2D1q+kurY8q8BY7xyTvr4GLaCFpLZQbiGgJiaY
 +r3YeOf2xeB6KyEuvw/U19FxpOgHITyWP2XinH4S4aFNmdyKoOAHtvx3p09ki7+P3zdNjX0MxRN
 QOoIAg2ruegKWFloiNQ==
X-Proofpoint-ORIG-GUID: rdqtaQ4FhclSXN2H9sn8GU13TKz4TpKn
X-Proofpoint-GUID: rdqtaQ4FhclSXN2H9sn8GU13TKz4TpKn
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a848dec cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=it0rTjz8NAFePQSC40YA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180124
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jim,

On 8/18/2026 6:31 AM, Jim MacArthur wrote:
> This is a subset of patches from Gustavo Romero's SMMU DA branch work,
> featuring patches from Pierrick Bouvier and Viresh Kumar. These add
> capabilities to the PCIe root port and ICH9 SATA driver, and also refactor
> some code in hw/pci/msi.c for future use.
> 
> The goal here is to upstream work which is independent of Tao Tang's SMMU-V3
> patches, while those are being reviewed. If/when Tao Tang's patches are
> accepted, we can proceed with the remainder of the SMMU DA work.
> 
> I have spent some time understanding these patches and believe them to be
> sensible, but some parts of them may be outside my understanding, hence the
> RFC tag. In particular, we may be incorrectly advertising features here which
> are not actually implemented; although this doesn't cause any problems I can
> see with Linux or our test suites, I can quite easily set the feature flags to
> zero and keep the code structure if that's a problem.
> 
> Jim
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
> Pierrick Bouvier (4):
>       hw/pci: add IDE + TEE capability to PCIe root port
>       sata: add SPDM + IDE + TEE pci support
>       hw/pci: add DVSEC RMEDA capability to PCIe root port
>       hw/pci/msi: extract msi_message_address_register
> 
>  hw/ide/ich.c                       | 72 +++++++++++++++++++++++++++++++++++++-
>  hw/pci-bridge/gen_pcie_root_port.c | 38 ++++++++++++++++++++
>  hw/pci/msi.c                       | 19 ++++++----
>  hw/pci/pcie.c                      | 15 ++++++++
>  include/hw/pci/msi.h               |  1 +
>  include/hw/pci/pcie.h              |  3 ++
>  include/hw/pci/pcie_regs.h         |  8 +++++
>  7 files changed, 149 insertions(+), 7 deletions(-)
> ---
> base-commit: fa19879df1658f96ac07365fca8835b7decd6995
> change-id: 20260818-jmac-rme-da-prep-8096fc816eee
> 
> Best regards,

thanks for posting this work.

I didn't send them at the time because there was unfortunately no way
for our community to test them, and see how they are used. We're still
in the same situation.

Implementation is strongly coupled to the work we did with Mathieu
Poirier for support RME DA with QEMU, which is coupled to current Arm
RME DA implementation. This one is still a wip and not yet upstream
(across kernel and firmwares). Mathieu has better information than me
since he kept on following this.

In particular, our choice to add capabilities to a SATA device is just a
consequence of following what Arm did with FVP. nvme drives have other
limitations with RME DA at the moment, and it's uncharted territory.

That said, it should not hurt, since it just adds capabilities to
existing devices, and if maintainers are ok, can make its way upstream.

Thanks,
Pierrick

