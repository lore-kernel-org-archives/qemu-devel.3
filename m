Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F760703FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=krKB2cSR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IqKFaUzm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1Di-0000yu-3G; Thu, 05 Nov 2026 12:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP1DZ-0000yO-9L
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:25:42 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP1DW-00082v-Qc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:25:40 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EQE7F494430
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 17:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YmIqkluugTQ7is2pURsbAbMT/qEs8POvoR2pLWuhibs=; b=krKB2cSRHPgHBGHh
 jdniJu3XnqZ0aDuwWdQcURmHFPPzKFtNrHBYGzqx7TQVQcbDCIqEc71zrEWIAlJC
 V/sxTC9zczmsu0UOIT9mUIAlVgstpOH2qcO2XiRlGEqF4oXB0+xq4JlJfoC6SYr8
 JUVGcgMR/3NrhjnsEY0r22Yuw7bIJeOkHZqxVv4PoSW+yM+X1/54QE8vDMmwynuD
 E9GJgFTCgLxolUD3DCNlup5OI7UvnG5YTv5/DRoe8Jw4D8q8jAY1ey5KFk/5KH1J
 pzw6RvjmZPloFYkNOvcLy6YWkElOd4TCqp6oMdETfYy32F413x9YupsI9I194LC0
 9kM1Wg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhksxr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 17:25:32 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4cc89e86e4dso2880522b6e.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793899532; x=1794504332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YmIqkluugTQ7is2pURsbAbMT/qEs8POvoR2pLWuhibs=;
 b=IqKFaUzmgq3WMqpBswIpNvJ2SL2l6rq2ah3Y7S/jct3bjS5OrrRUFwGjDN44RuzcTt
 QzgXhW/d1EZvDAMUR38BWfd4UzLcmpeebyNwzllNI4ajDz3y8o+kA3pc7WUe2WyoRKPW
 oMGJ1vfuih4PAoBfyIADQ2DeaNPXiM4WCyGQpU7yY6DqkIJGm+jAsKuJYhci/SmTaZto
 iygekAGTKljh7rPeU2nnlPMxCUqde0Dp+aPM4IEdj2xZtEMvMgKK4KlgcX1yqBEqkIio
 pwk7bVfeRiM2DcK9RviB7xffOYNs7E+4tloPyvVBGHkmS62cEv+1eOB5P2UjkjaJoZA2
 i1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899532; x=1794504332;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YmIqkluugTQ7is2pURsbAbMT/qEs8POvoR2pLWuhibs=;
 b=23272i2tiRcwi2Pgr5JIsWp6GY4R36KxkIgHxZlgDQFZA262bob8bwgb9gN+pYWH8M
 lu06sYqGA5bxIi1eCE23xjVdXpNf+bTn7CKgumHfBj+HUkO/X+6U6/mup2iI8aO9OSzp
 kqfkYOGg5Nk6xaCHhkHF18xeG1abX9KHhwdFiu0lAA9Fk7B2jp9Wl6fnyjJbRrFy3eCJ
 eQLEvUZQ0s99NxZa/5WLMHqzGPx4LvJRRGvR8QMAJzNChCaydgVV9/G5amP+73hZEFdG
 gf1FOZeOixUoB8b6VJ4eSMI0lOKmmcpMTXKwbRGxXAqAsJRPnlN9tig9RvKHx9JRBDQ+
 ypug==
X-Forwarded-Encrypted: i=1;
 AKwUvBwk9FJQJPpOKyLmmdTWlo3RlejDO/im970pziFyJeyGAhsPc9a2o5dl9KUyxoY37VP4j9+Ge2FG/XYo@nongnu.org
X-Gm-Message-State: APuU4Z/nyfovjDp7hWzFlb4SdsxJfdlvT7MjdI8/zlUQGVpIi8bNRp+x
 zFZaEgur4EnXPuu4TK81w12wtEmDDUwG6LYlPAIfnbHhWtHhMFCmXBHkT4Z4gPfALLeE6bpKYic
 vSmin+YVaERWFAK93GdVwVyHJ8Q/xCTVWudKOdd+sT7BnJOeFHeBBiXGJ2Q==
X-Gm-Gg: AYBFou183NDr4HH/AQ53TopRSMhby1LgyGdZh0SJkNsph6dnvEMpfCr1ZrfAtnYv6Yd
 K7AKQgiDxdQNvv7p3aLRIjMiUS1gnWbCKgyS2TBsFID5YAHsyJo9pwFQxvDCxiwCBAZIC4LLFv0
 P9AfAQf5kYjOruuba2Py4OQ8Ep7VRAAn4FiPWRwJEuFI0WHSPDe/pC2tNwm9UFXE5I0MY7OkPbi
 BwCRAjvmzcP8XfEvyT10Xhyp/Q6IHeZ21VGDy8zOjynb8TV5znCLGD9iFknGWU6wLGL3miyo8G+
 xSeofsBRrX6aqdXWFDlKZljq94V8rRfgE897aL5THbrNJXDz6ejtugemI5PmrES+cT+I8gfrbvP
 WeKQTwRKCwgEkI0pcxWgm9v8jE9efzDF2dDpVZXeTZbuPi1SJW/jvP3JuiA5CaT7rhB8DArknCi
 CciK0bgtoA3KEwruSWlYZi9UHx4zF4XEMXpPkT6GgdpA==
X-Received: by 2002:a05:6808:518b:b0:4d6:90d3:e18e with SMTP id
 5614622812f47-5640de24f08mr14504493b6e.45.1793899531540; 
 Thu, 05 Nov 2026 09:25:31 -0800 (PST)
X-Received: by 2002:a05:6808:518b:b0:4d6:90d3:e18e with SMTP id
 5614622812f47-5640de24f08mr14504459b6e.45.1793899530989; 
 Thu, 05 Nov 2026 09:25:30 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9c79f00sm4759474b6e.2.2026.11.05.09.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 09:25:30 -0800 (PST)
Message-ID: <e0afc971-a070-4853-b690-b6c523c5b65a@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:25:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw: support machine filtering without is_available
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261105102432.1131493-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261105102432.1131493-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2OSBTYWx0ZWRfX3OLA4vhD1ktJ
 qcNNOImt3uvyS6HQukxVXCYcvcrRCjPpxHgvDeqK0E7I3rcimgWKGDSPcU3HJDUXcXsEL5IGIRQ
 saTDiQTH5nVyGTfZipnYnkWYTZSPOPRtAhae1J38Ep7HkeDEn+h4J6nbGuICe53OdtZBesAbm/8
 QHlQ+PYscBl/rS5GwjpDHxxp+QRo9vhgDao+4goeYgQ+Mpe0PDCr8KLzYRjAT5aejMxye71BYZU
 +r6GXBTxqaI8xAa+XUWZBU34Mv9bHPcZpVTH89q18lN/8quKrdNH3rAHz17SbC/foBXnZZ/JPim
 7Qvbma3IFiBPn1o+TOVZYMugX0nhUQg8ej/W168PTeBErcZ+uCUPK+pNic3jmyu1ztaUNSlCnzJ
 H+UPcYtXo278llMgZ5a9D9fqJ2Fj86uQnhFBeFQ5cPK9ZjusAHG+SAON5+lJL0nbSHLD/pKq2TP
 kbL9j84w9wdEF5FJG0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2OSBTYWx0ZWRfXx38MySGTOMHX
 jat0H7rhsRaJAu3EfEAqeExwY+5cCc0Xj6wksZDagaaOtLxD0znU3AkJz2nlydlF5QWypzzz/vG
 /dTNLYcMPqCgcrFhNlZmSKGQ1yO7dnM=
X-Proofpoint-ORIG-GUID: RMECoJOu1lHJyixaOk825iqfiUq7-4IO
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aecbc0c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=w7JVH61Qi7eByEQ9bWMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: RMECoJOu1lHJyixaOk825iqfiUq7-4IO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050069
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 2:24 AM, Daniel P. Berrangé wrote:
> The 'is_available' callback on TypeInfo is based on a mistaken
> notion that we should filter out classes at registration time
> based on architecture.
> 
> This creates new problems however, some already present and
> some which will impact a future multi-target binary
> 
>  * For introspection of the binaries' features, we have
>    a dependancy on selecting a target before we can
>    introspect features. It would require re-launching
>    QEMU for each target, leading to lots of redundant
>    introspection and a big time sink. It would also not
>    be possible to introspect targets
> 
>  * It creates a circular dependancy on QOM initialization
>    inside the QOM initialization code, since 'target_info()'
>    itself uses QOM. This then requires further work to break
>    by initializing QOM target info before the rest of QOM.
> 
>  * We have no means to introspect what targets a machine
>    type can be used with, as this information is expressed
>    as code (in target_XXXX() methods), instead of as data.
> 
>  * New fields in TypeInfo requires more changes to macros
>    used for initializing machines.
> 
> There is no inherant conceptual reason why we must filter out
> classes at type registration time. This is just a shortcut to
> workaround historical technical debt where certain classes
> have clashing names. This is an undesirable approach, as it
> is trading one set of problems for a new set of problems.
> 
> This series proposes removal of the 'is_available' concept
> from QOM, and illustrates handling machines with full introspection
> support available from the MachineClass.
> 
> This implies fixing the root cause, of clashing class names,
> but does not include patches since various series have already
> been posted for machine class name fixes.
> 
> The machine changes are fairly simple
> 
>  * MachineClass gains a 'targets' field which is a bit mask
>    of SysEmuTarget
>  * machine_class_is_available() matches 'targets' against
>    'target_info()'
>  * -machine CLI enforces machine_class_is_available()
>  * query-machines filters on machine_class_is_available
>    by default
>  * query-machines gains 'all-targets': 'bool' to opt-in
>    to returning the unfiltered list, with a 'targets'
>    list present
> 
> NB, this removes filtering from riscv CPUs with no
> alternative proposed. I'm unclear what this was trying
> to address to begin with, but utlimately it should be
> possible to address it with runtime filtering/matching
> of classes, instead of hiding TypeInfo registration.
> If someone gives me info on the CPUs problem I can a
> make a design suggestion.
> 
> Daniel P. Berrangé (4):
>   hw/core: record permitted targets against MachineClass
>   hw: replace 'is_available' with 'targets' in machines
>   target/riscv: remove 'is_available' from riscv CPUs
>   qom: drop the 'is_available' callback from TypeInfo
> 
>  hw/arm/aspeed_ast27x0-fc.c  |  3 ++-
>  hw/arm/aspeed_ast27x0_evb.c |  5 +++--
>  hw/arm/raspi.c              | 21 +++++++++++++--------
>  hw/arm/raspi4b.c            |  3 ++-
>  hw/arm/virt.c               |  5 +++--
>  hw/core/machine-qmp-cmds.c  | 18 ++++++++++++++++++
>  hw/core/machine.c           | 13 +++++++++++++
>  hw/hexagon/virt.c           |  3 ++-
>  hw/m68k/virt.c              |  4 ++--
>  hw/or1k/virt.c              |  3 ++-
>  hw/riscv/virt.c             |  4 +++-
>  include/hw/core/boards.h    |  3 +++
>  include/qom/object.h        |  3 ---
>  qapi/machine.json           | 12 +++++++++++-
>  qom/object.c                |  4 ----
>  rust/qom/src/qom.rs         |  1 -
>  system/vl.c                 |  9 +++++++++
>  target/riscv/kvm/kvm-cpu.c  |  1 -
>  target/riscv/tcg/tcg-cpu.c  |  1 -
>  19 files changed, 86 insertions(+), 30 deletions(-)
> 

Thanks for posting the series.

Would that be possible to complete it so that beyond compilation, test
./build/tests/unit/test-multi-target passes also? At the moment it fails
with duplicated types being registered.

That's why this is_available was introduced in the first place. It was
just a way to move forward and provide the multi-target test to prevent
regression while work on single-binary is continued by Yonggang.

With a complete picture, I would be more than happy to remove
is_available, I have no personal attach to it.

Regards,
Pierrick

