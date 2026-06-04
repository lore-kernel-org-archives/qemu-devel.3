Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EC3CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVG0M-0000E4-7o; Thu, 04 Jun 2026 17:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVG0H-0008Pg-BG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:53:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVG0F-00077p-Bx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:53:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654EpfbG528942
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 21:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3HDVOfHLcypXbTnD/GrYtzUdJkS8RtM1ERyidCptj1E=; b=m0nuBNwFQcBpIN3p
 NnPX1f1xpJBs7gWQBWmYOyyYBlrC3yHUjBFQEdvoVSijQUxtaHwFPImu2CQ0UssC
 0xYl+jsx3qpnb7sYhPBOk4N2nTEH3SAmUJ+8wGCDFn0qi7rg3/UIbiPwVtL36vJx
 I0Yk4YpSR/WBaMwXfwLrcnKp5T6aTHp1z47ZY3peKiGRi5c7VDtf5r7+y+98r9AA
 0dspZa/SOdOr76W3OryNze3K+Kg/hy6dRdt4Ta/tpQzR6kyXHJtG787D4+RFzTSS
 y2XvbbGGP36gZa56n7BOmRSufAr562+Gb3wlXodCO4zdqKXkiOC0dIVTy1su34KE
 xxHtJw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekbgdsv8d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 21:53:25 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ec73b015so2558655eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780610005; x=1781214805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3HDVOfHLcypXbTnD/GrYtzUdJkS8RtM1ERyidCptj1E=;
 b=HYDRigzwTpVJs9NN5cDOzR4tCL2eXTBA31M0h1Y6lrIBeHiLi/x0drtjbjdrRRvtaf
 sLjkBNEgYVTJzYysXzPOHnzxRvWbZGCNGNE7yrb2RmjSefBYFQbiIzdK9TsaSBy4TAM8
 ghxGl8X3g63Skt0Fn6HzmCMzhLv8t5LXFC+FNaoleisaLp0trZFm4hUwvncDctEXSRqf
 0Adeo78O9Qee41rMzyxzHlz032OHvvoupomeKvcGQ2pGZ6kgMQMkZrAn1/jMPQMqPq+X
 QC2N3t7VjTsUPv98BwkewYfUfsCOyJlC5SpTQCKtw1hHz7XATss+V1aeyz+XlJEx7SZg
 08pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780610005; x=1781214805;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HDVOfHLcypXbTnD/GrYtzUdJkS8RtM1ERyidCptj1E=;
 b=i18NIBEHwr1r4qb78AHueTvs5swRpvdR/45Ug/yK+pFCp8dxcM1N5uVT/pa82Zjo4C
 jWhYM1ooxQV5WO1o4duia7oKagNO1bb3k4dpS0YR0ArNazkI+0jCLXLCzoqFfXUd97QR
 5Ki6jcScg/A4rK5nxJYM5k6b/gFikKNvtIHs1b3EBCTRFEpJg8KIkE2ddwkXGcCnSRyb
 aA0pAEjS7jy1TmBNCfwd5btx2A2TDjNMMIfFjw6fDCKa2Ecao3FbvqCifWI89yBsKP8n
 ngNeVq6W9vOaqrn02nbZH3e0a4DETLzdIEWBaWTRfiY0i7Pn3s3BtuWmp41I6gGbx0fq
 C8Kg==
X-Gm-Message-State: AOJu0YzTKM7FDIp+C/5r8qr+CxiEkqmbeBHvB2q/Sv+kFm/wbOVlXupj
 tsoOSYOEL9n6DhRQRMubHVi3mwW/x/IpwgtWtiGhjxAHfirapY5W5DWJZeYGlSqUv9lFyHZ3Uzf
 D95BfmsbkN9MkWyIQ9xFZkDWGYd3HNvBJQg+tDSXr6NVCyiQJ7144rJ5ATUd6Bg42E9FV
X-Gm-Gg: Acq92OHtBkMxKZoPCxJo7LN1PitLnhnG0ub284wljeDDuvqDPrtiq8eo8JtMDQJTV8o
 nmlQNT/v49HA9jr+zPo8NHK2rwFl12U/RqkDgQghuSDrJCkbU2vitR8v6ajiRAdHSZ4nYp5bpff
 mvP4ef/j9Q/IkqTsrea4MJ9neMT4HcgCdeaW5X4lV7v5BEpC3VgCrDNp8E5/vrZwkdXKQkpcrR5
 UkLeTm1w6mRZDJaE5e1m9jrw/Qwb7SSyXBkQj+3KPtl19Tby+2kufjMV1k6envMco4/eza6lOYD
 HHXIbLqoW4MobwiNRrbgpM4KeAqYswGKuOrFk60/Vos+ZYZCnmaeWTYYlUHywSbrWB90QFONgFu
 f16KxnH42Si6HzKPmmP9oFeAXpG1GSD4mCBeqRMwZl5/7/jGOPo13KD7R/fF1NP7mrrupbQJWeh
 90ZoSzLMgSzyIfBmHwoPQgmiE8
X-Received: by 2002:a05:7301:1e84:b0:304:c520:4e0c with SMTP id
 5a478bee46e88-3077b2707b0mr308490eec.6.1780610004544; 
 Thu, 04 Jun 2026 14:53:24 -0700 (PDT)
X-Received: by 2002:a05:7301:1e84:b0:304:c520:4e0c with SMTP id
 5a478bee46e88-3077b2707b0mr308469eec.6.1780610004019; 
 Thu, 04 Jun 2026 14:53:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df77a0asm6478698eec.27.2026.06.04.14.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 14:53:23 -0700 (PDT)
Message-ID: <88aac291-5ee8-4307-8de3-4280d59aa02a@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 14:53:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] gests: update ubuntu2204 to ubuntu2404
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fjC9wdB8GwslV4feujIvWknR64e24T9Z
X-Proofpoint-ORIG-GUID: fjC9wdB8GwslV4feujIvWknR64e24T9Z
X-Authority-Analysis: v=2.4 cv=a8cAM0SF c=1 sm=1 tr=0 ts=6a21f3d5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=mkg-ff_Mvfj7XMvBLCUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIxNCBTYWx0ZWRfX0T+taF8tN+bm
 3px7Ifch1ljyhBARsXjKSx/ER2DfWls42Vk24Sbgl6jyvFeqc70MV9hRkPcVlAApMcvdjeVZ1MM
 fJkauotBZCRpq9qe1/u1G2xOYQf/5AFeh5a0+pdEwTt6Z9XACsJJtRxwlyoZWslq5KwW3CcsqOn
 XgS/9dZrFznGucrqYcRyNqQfO/OjhnOoAuO79rZX1pVij9Cw7FxXC3Hn0f7AbL+ol+/Yzyssn87
 W1nACQy8wMkTLIN0mGSlbR5xDV5lSWE6tdbnvMTURH7N307fnrI6TvsDFu6n7HtXamjcGZSsnCe
 qEiypnsxKKMFEmBoVS1V5lMGA/f6VDi3azkjxNvpqHTy1nhWYVcyJctX7i5GB4L6uFxjq6CbjfP
 xpXgesla+cqGgEDkn1sDUBlERLqKJdRyHu6yWbiBaO6mTApnDbqEvZzngwqT63w/p0vumFCyA2K
 EaBB98sSiwnp0azRsDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040214
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/4/2026 2:51 PM, Pierrick Bouvier wrote:
> Ubuntu 26.04 LTS is now available since April 2026.
> If I followed correctly, we support latest two LTS releases, so we should be
> able to update. If not, feel free to correct me :).
> 
> Pierrick Bouvier (5):
>   net/af-xdp.c: maybe-uninitialized warning with gcov build on
>     ubuntu2404
>   tests: add ubuntu 2404
>   docs: update mention to ubuntu2204
>   ci: update to ubuntu2404
>   tests: remove ubuntu2204 container
> 
>  .gitlab-ci.d/buildtest.yml                       | 16 ++++++++--------
>  .gitlab-ci.d/containers.yml                      |  6 +++---
>  docs/devel/testing/main.rst                      |  4 ++--
>  net/af-xdp.c                                     |  2 +-
>  .../{ubuntu2204.docker => ubuntu2404.docker}     | 12 ++++++++----
>  tests/lcitool/refresh                            |  8 +++-----
>  6 files changed, 25 insertions(+), 23 deletions(-)
>  rename tests/docker/dockerfiles/{ubuntu2204.docker => ubuntu2404.docker} (95%)
> 

You can find a CI run with the new container here:
https://gitlab.com/p-b-o/qemu/-/pipelines/2577599834

Regards,
Pierrick

