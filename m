Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99546606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oF399902;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OMxfFNHb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVntf-0002r3-NL; Tue, 24 Nov 2026 05:37:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVntd-0002q6-M7
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:37:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVntc-0003Hh-28
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 05:37:09 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8QnuM3701759
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rFMX1GjX7d+af+dG47j3cZfwGXzeNKRyLeeK5SFrpD8=; b=oF399902XaAeTd8A
 OPG1R7Alg5XuRLkqPm+IbeuO4TQCnivxQTcNsB2BzvOuAzkCb9WM6/jzn9HC8cUh
 KgJ8uOn5kAyVYhuGt+2U4QIDF0GX3ySXHUbqLeIt1j+CXw7DlM5M30piTUI+rt4X
 Mx0rdGQtNdwOt+5kg1SOOBtAjqf114DTNocZ6w9JPvlDatSjiFkotQw5I92lYWvW
 Qk0HapEw91dvfiZYUf+qCVUOz/U+W2As3pgBmFYu2QGoyXlgVjNPQvMRyXcGg8AO
 /FH9LQqWQnO8ueLOWlImUZM0CpVAlzX7uEiTgPXVNOxYrtsDJ0T6nZClwvBvwPRO
 sdarhg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky23sd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:37:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961511b61so729799685a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 02:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795516625; x=1796121425; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rFMX1GjX7d+af+dG47j3cZfwGXzeNKRyLeeK5SFrpD8=;
 b=OMxfFNHbtzT/s7HKvpAGlPUyuLP4utk4dIlei6FBgoRxmN63lnvcQ+Tf9xKypzzBwA
 hRUYiU+STVWi0FvRQv+A9bRg/7y6KTZvdHdLfnRIMeP1aVOBQ295VKnnjYm/BtPnN0xQ
 jLiHBLvFOeKj+afoEt4rpUVS9Wsj70ZdxxEPxUUMwuAfTZWviFcCsS3DfmAo9sxaK71v
 e66jHn11Iqzw8fLwqG3agjnsS4r5k5/V++EcvK02l+ojFAwjZqcYK2sN6UIBFUIPE8Bw
 Gg7Pkv7Iyk6zJeVBp0gtgUNufilxRP7JKWhBBeD9vuCHkcWjhRAxouUK+sQxHOPVZ1wJ
 GciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795516625; x=1796121425;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rFMX1GjX7d+af+dG47j3cZfwGXzeNKRyLeeK5SFrpD8=;
 b=QY34Z6BJ23c7vvDozqcr+xbqUdpTyqw7zPVLY8d0go/gMK6ErkkhwPhrktIC4c7eyJ
 TME6etJCwavUsX6URYWhv4pZdZW/+trUmTkn71XkX8ENkI6qBPkpqKYosi+Gfo+pXGnI
 fXIG2A7gg20EQyJqEmnkCGxVu9eKa6+VNqlzcd5dwyxCFQmZh53sya5BNKqZQNyn201H
 5Ly/elSsfkaieDP23efHK61bi8NAa3OIeXrFatvqribHXay1PWASdiSMsQD3noR/0GVr
 lj78JQUUlhQwtZtCYKrPJe1INbztHDssYnuGQpBivu5YBhgxGiZOhysl83HHI7cD9X2x
 dfzQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFma2rtGMCgtFXz5Mbvx8D5c2xZi7oBL7i/moFXzcoFK+S9+XrV0Vu41onWmFk+VmTHOhKOrQ8v/5O7@nongnu.org
X-Gm-Message-State: APuU4Z+uNSvbsMnniWgJ+DRphO5zhQKZX78iRvA02hCpjuRkNN2IFIP+
 aEOf9iKLicJMbTrF2LbYCHlFGKJNeqPOF1s1HPlzNQP4XKL/IFSIZcUPVf2bR+7kbiXUFuqW3ms
 RGNmhyUIfrbXQBuX4AK363GJK1AeDASsXuyUMjYpRYFd7YaX7mvxta6D5Sg==
X-Gm-Gg: AZFdTZfXUgiIBz3Afx5hka3ocMeqP8DTMqY0sM+PQ61GruiCIiT3dW9p71daMFFlB2x
 J4hrYD8gp1ZziThsLJro9iHw53bv8Blpa9nnuU5xwANR/MmpYaEp2CyKppdw6cj6+TXSxoG6kvK
 34cCSvY+Hj3d8fEOfe5gmA12dsOF4ufHbIS5NEwBmz3YThyn85HmGD/sZAkZxzmArnTwLY5IPlF
 lem+3X0NgW8X9cDtrGzICZgtLudG0KfkPz2qPXnAoQfnVFmcljuyU5FV72n1gzqLYlcOxbkQm1S
 bUcnKRyD9yhVZKOAnTaSFUhEyNEGcsyaJaRoflVF4MfCeTnH7DN/d7TgmqEcOiyaONpp5mPsV0P
 9SqlFKVNW2kIEqsvZ9AOkrcH6dcX30J5ezHAbOpXC0iMOeYmlWaAq3v/6qLtYahD1397+pbtvsM
 BkRKxkAK8=
X-Received: by 2002:a05:620a:45a3:b0:93f:568d:ebbc with SMTP id
 af79cd13be357-949ba98e6dfmr2367365285a.32.1795516624812; 
 Tue, 24 Nov 2026 02:37:04 -0800 (PST)
X-Received: by 2002:a05:620a:45a3:b0:93f:568d:ebbc with SMTP id
 af79cd13be357-949ba98e6dfmr2367362285a.32.1795516624296; 
 Tue, 24 Nov 2026 02:37:04 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865b1sm420209335e9.5.2026.11.24.02.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 02:37:03 -0800 (PST)
Message-ID: <2216d59f-1c2e-4c15-9018-f63cce8ceb3b@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:37:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PReP] Maintainer status check for PReP machine
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@pond.sub.org>,
 Utkarsh Verma <uverma@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth
 <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>, Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
 <87mrqyhb7l.fsf@pond.sub.org>
 <1fc28def-9c77-45a8-99d4-c1de8dd2d477@oss.qualcomm.com>
 <CAFEAcA88U2ef+1LWP7rP7d9=t8gtv8nOkzULBbTGG3D+ixOCSw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA88U2ef+1LWP7rP7d9=t8gtv8nOkzULBbTGG3D+ixOCSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b0568d1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=vUPDPdP7UYfhdZFVvZ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: psyZtb08u4AqRGuzW9-CIXrMD-v4BXUC
X-Proofpoint-ORIG-GUID: psyZtb08u4AqRGuzW9-CIXrMD-v4BXUC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX7GECG9o3ghVl
 7esFMilzi7PFAj8JY06Dk9viTQ4GfPFtrfmytCwt3EXq+hDXWRud24E8gCdcqxM5pUtwDat/EkM
 qHco2TIxpTuFfxHkbxtg14EC74ETUKI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfXzVACa/pxEapo
 0ncq8uQ0wMNetjhX4+3+KNFHGKr4IenVElQXw10VLvkcn/xMm5OuLWQ6ALlgG63AmjZKBcHZ2vP
 VQ58K0lgT09zAPrM6bw1THmcFtl2foqRfNQXPzKixz7bcIZOtSlmWL61YaHUpjL51Ux74GzSj4S
 +4JWyz9I985u6EByoJAMj+B2ptOopw6l7BC+iENLNAUxoRVd2b1Nr9PUW6oP6TrS0kL+OH+PXZz
 0hte2aw6oDQOjIZzNqy41lJDQCfdTgSayuxPyBJKo/umt+Bz4EYEVO5f/lQPv0zqLSsOm3pqjAO
 DrBs9x2jGC/bw4+89z+aMj/VmiRenBOe0EamA9UTaW9/L21JUkNCcnZ7eCmNrO0ziMgsPAx9F4V
 I10UwZhGK0VlG/7pEb7rd3DAQW43JfE6Qk46P43RYIHVnzUqJwMW1QN5DlGn25XzsMDBwYdE7OM
 3ckNyLC+ZIA72qgB/+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240041
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/26 11:19, Peter Maydell wrote:
> On Tue, 24 Nov 2026 at 10:06, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>> I'm probably missing the point here, I'd rather look to help maintaining
>> unmaintained / broken subsystems. Why care about a well working area and
>> ask the maintainer to step down? Why not ask the same to ARM / RISCV /
>> X86 maintainers? What is the underlying problem?
> 
> The underlying problem is that it gives a misleading view of
> whether something's actually maintained if you look at
> MAINTAINERS and there's an "S: Maintained" label but in fact
> that person hasn't been actively involved with the project
> for years and is probably not reading their qemu-devel email.
> If the real situation on the ground is "effectively this is
> Orphan and patches for it are unlikely to get review" then I
> think it's better to have MAINTAINERS say so.
> 
> This is why at the beginning of the year I did a run through the
> MAINTAINERS file to look for "stale" entries and query whether
> the people listed still wished to be listed. (It was about 50:50
> whether they said "yeah, it would be better to not list me" versus
> "I do still want to be listed".)

Hmm. Utkarsh should have mentioned that context first, hard to
otherwise guess.

Are we trying to address a 3rd class of your survey, people who
didn't even replied?

> I don't view this as "kicking out maintainers" but rather trying
> to make our maintainer docs match reality: if anybody I contacted
> in my run through the MAINTAINERS file requested to retain their
> listing I did so.
> 
> We can discuss whether it's better to do this as a coordinated
> process over the whole file versus single subsystems and who
> is best placed to be sending out the queries and whether that
> works better as private email vs cc to qemu-devel, but I think
> the general principle is right: many people who drift away from
> the project do not actively send us a MAINTAINERS update and
> so we do have to do a little active housekeeping on it from
> time to time.

Since you sent the survey, I'd expect you to send the finalMAINTAINERS 
update.

Instead of having individual status checks, the process should
be automated with a script, likely running during the -rc tags.

Regards,

Phil.

