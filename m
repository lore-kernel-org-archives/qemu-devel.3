Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F02606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lV8w0MZq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hx0kbUdM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKQsb-00075M-LB; Fri, 23 Oct 2026 21:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKQsP-00074E-ST
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 21:48:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKQsN-0000Oy-9v
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 21:48:53 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLutJT3115340
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 01:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TCM7LklnfQM7OoPR1BG2HnUkUsDDScsv+b4qlLwbbLU=; b=lV8w0MZqERNtftKb
 aol4oKqDuUls6u4HLh5JZ50wdxaMZfTXRpZiqYOVib3Ye0M29KozUz/rhLGQ0zOT
 S2UmYQeFW6CSCRC0zOJlbncDc924/QqcJXegBXtU1zVREaOOlbxY3aFYDi5n5rIU
 h98ZcJcAlwMeoCs+IQ0yC/XNyvhKNGAjIaoNSS5tVZmbG8/t5IvJAUSUyhh6tt2p
 rKbe4qsY5HLECSOZJbVl2GBj3rQHiDRXlsUllhnokHl+BZCLHWrUNnsMPVavvz8W
 QcdK8aTrGEy9GrDt/NiA0L2jPKIhXHEEVGvr8czLBMMbF0ggR7wLhsPITNJtHyZu
 5Gkltg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrt96ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 01:48:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so1975132eec.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 18:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792806527; x=1793411327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TCM7LklnfQM7OoPR1BG2HnUkUsDDScsv+b4qlLwbbLU=;
 b=hx0kbUdMl5UgPqQ5LzGqjI5PaGzxNJ8cxkTO7KDV/FBacUBsmkhLzNblrRg0eoFDrm
 xOsgkZlJ4SgpGGEqVHUZMhdKDrZxKwKgfuWwfdZ9hAsbT2mnzqVCQ4PcOeLvLJ7iyvPn
 M+dooOZjI4/sEHfHMcuXiVnLQzuJ4ayZQ6klPA5X52UXIYqo3xz3K9Q05v8MaF/zXOKV
 F8GWPutq+euwKJxyrozl0eZ7jhayXjr8XOLUbwlmjelQqB3kdqsYYIybvhxjkaQu6C4q
 6P/AqCq/YNmtdKJ6LfAj0GZ9lzzNgh3tyyU7b3jFuhnpdpkQ/Oaf/tcXM/gGnZGvXakV
 F0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792806527; x=1793411327;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TCM7LklnfQM7OoPR1BG2HnUkUsDDScsv+b4qlLwbbLU=;
 b=1t01Ws5bfVBVb+EHaZPHCPSnQM1CjRygKLl+ce960SypoepQCtYSZP7ry0wE2PSziU
 s9/A9UJCytJcwq1Cjg1wHUlJo4HwlZo2WaymeL/4faa2p3zufWMxDzUeSP4aoVbo0Exe
 eH5jjrKnfFp0iqrpfzt1QzotY4A4P1ODJ+1i8lGTZaYu6oOfjdLxdQ2Eg0JZCqcExkx+
 k9bEr+cvrsRS16t13h77729RaoXYTdRAo/0F4dwaUsEBgevAeE+uC3chenYkqVuuiuOo
 8KRpXbL/HjrXUKcR3UVQqFM5kPACeBzRXhaXq43nM1mhCf9f/Tj9Mb76HKzpPQUkN9Is
 1umQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByBsmis3qHg5BFuzNd/EFQnfc6UWg8lt9IJCFnx5m20iNYQ/SUM+C+unO33NrTKtQqNobKKpCpLS0OI@nongnu.org
X-Gm-Message-State: AFq9FYJBpxztduge8gP78q82oYdcAJm61ppExPnZwDHbyVI/S+fWzIpI
 TurwBV3cfXRypPcGeUrsKkD2WiKQfori/z1W/RdqnbXiSTvB7JqAYm/4wh1d5JyaOsgXWVv110p
 VWLzW5uJgeZ68tPktCneMn8STHTbvLtixCHVnCn6O7nQXHxbqNkHjwsEF5g==
X-Gm-Gg: AYBFou3pgeCJNSJZek7Bx2v1bZ8m31Hd93DlxU+5GUqFpr+97Nfv4C0gHE5dKEi4Obm
 4pNovwJA4pS1xHB1xH3cfiyAP+uG7OZB6Lz50+Cr2aI2io+8E6aPSxka/x6/HdTZDQrXuF9oC3y
 B5S/0aUtTBGZ0Aduv5e8W6hNdl7F/XNwwWYjoE1otTzBP+9BFv6YHRXfnjQzar6fz6N+fp+X2r3
 SGE2sKBJXWyaJtHft21I/9UnLhqrkG/T2Vjgf2FcDywD6BLuPPXYwLIhIyv7h4ELdRnAPXhbobJ
 cm0uzIPduSa494WzW/woinQpS58LVXnkZ9T6N1r3pq7/Wfq07ZEgSaBncv9+He/Y41KcSQl1kYk
 5NcGbk2xIOCtg83qAW1zExlKCjGMrmBWsAB15OmAUGfHa8XbGOwL9FsmQaIx12v/LUfzEmg==
X-Received: by 2002:a05:7300:f3cc:b0:35e:c56b:fd73 with SMTP id
 5a478bee46e88-369e850e387mr1290609eec.38.1792806526989; 
 Fri, 23 Oct 2026 18:48:46 -0700 (PDT)
X-Received: by 2002:a05:7300:f3cc:b0:35e:c56b:fd73 with SMTP id
 5a478bee46e88-369e850e387mr1290583eec.38.1792806526237; 
 Fri, 23 Oct 2026 18:48:46 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d845ddsm2093491eec.11.2026.10.23.18.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 18:48:45 -0700 (PDT)
Message-ID: <c4b4213c-6013-4a96-aa13-509778bbb6eb@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:48:44 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] releases: build and run any QEMU release easily!
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
 <87h5icl9dw.fsf@suse.de>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87h5icl9dw.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfX6rVhJx56PMCx
 rOYFCg51BSgYfA1BE4HxOSkiJEEOILvPf0aY6oNS4c4wfPzEE1cL7H1pxWLERJ1eK7glpLbn4j+
 HoW5m62BbO1uxlOEpm4Wv22zj/U87wA=
X-Proofpoint-ORIG-GUID: 7Zo4nHpzOv0PBM-IQD4CUV15EqzzJVuN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAwNiBTYWx0ZWRfXzYmgQ7QGiJfu
 d67JlhlW6NkvkNZTsBKIpyWs5CEeY8C4Tty9o5YnnuwRrUrlMiqvjIoFrbqOMOHdTgBnODpOZHL
 dMVt6aQwYrLTB+0d3DFaHVoJi5OLSlMpKW8e9rH5k21eIEvJC9yEVakmOX+QilDirUfWbAofHw+
 VD1k3SsPoTdqsQ2RsxkhYwb81FnYg5jJM5mPI//HGsLw7OrCWzsvo3sMq+dBu8R6+pBjRw6f2RW
 BOWd9MLTBuEZGeIzXWLtgOkRw1kODFJWwOt3ezG4RiZ4TYFpK2JaZMx5Q3Zhthhp22t3prZsM29
 sFIZJKwdX8VVRF52lCsuKV36Y6fSIpFi/+JKugJqoTxkz6jO32J2czVgjHeYwy4t3OmJCbtRJq+
 Xt/HIwTFAUMczeT+uvB9vrc643V2bsk9fMRWEsQVV1bVUBzTwNEmIUHNnc0D369f6/eGLnGzy4n
 sw3dUyNicsaPX6AxRIw==
X-Authority-Analysis: v=2.4 cv=E7lYNqdl c=1 sm=1 tr=0 ts=6adc0e7f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gR90GsoCkhilR3HWlPIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 7Zo4nHpzOv0PBM-IQD4CUV15EqzzJVuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240006
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/2026 8:33 AM, Fabiano Rosas wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> This series was inspired by a recent post from Fabiano to provide container
>> images for migration tests:
>> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
>>
>> The idea to be able to build and run any QEMU (past) release with containers was
>> in my mind for some time, so I gave it a shot. Finally, it was easier than
>> expected to obtain a single dockerfile (with a few hacks) that works over all
>> our releases.
>>
> 
> Good stuff, thanks for this work. I'm just not sure how much of it fits
> upstream in the current shape, let's discuss...
>
> You say this was in your mind for a while, could you elaborate a bit on
> how you think this could benefit the project?
>

First usage that comes to my mind is that it would greatly help for
migration, allowing automatic testing in CI, by just downloading any
previous QEMU, dump a machine, and restore it on current version. We
could do it for last 10 releases to ensure migration from packaged
versions in all supported distros (red hat, alpine, ubuntu, ...) work as
expected.

It could be a enhancement compared to the manual process done once per
release. I read many times in review "it breaks the migration", that
yes, it would be nice to have CI saying "this series broke the migration
from qemu x.y".

Beyond that, I think we could also offer a "rebase on steroids" tool. We
could extend list of containers published to all top merge commits (git
log --first-parent), and provide a fast rebase, based on download only.
See it as a giant immutable precompiled cache. Dockerhub storage is free
and unlimited.
Some quick math: Since 8.0, there are ~2000 top merge commits. Each
image is < 250MB compressed, so the whole thing would be < 500GB.

Finally, in my personal case, while working on single binary, I had to
compare output of qemu help between versions. I'm also interested to
track QEMU binary size evolution over time. And some personal fun with
software archeology on the project too for anyone.

> To be clear, my use-case is simply to produce a few containers for
> testing migration on my workstation. Your series can help a lot with
> that, but from my point of view, some parts are clearly extra and some
> are missing.
> 
> Also beware that what you're touching here is both "infrastructure" and
> "publishing". This has implications for how people consume the work of
> the project. There's a chance that people see this as "official QEMU
> containers" and try to use them in all sorts of weird scenarios that we
> as a community are not prepared to maintain. You might get some
> push-back on that basis.
>

Sure, it was free to generate all images and push them on my personal
dockerhub, and it's now automated to push any feature release also in a
GitHub nightly job. If we want to make it more official, it should
really be hosted on an official account.

>> The oldest functional distro we can find nowadays is ubuntu 12.04. Because of
>> this, the oldest QEMU release we can build is v0.12.0. Previous ones require an
>> environment we can't get easily today.
>>
> 
> I think the ability to go all the way back is very cool, but unless we
> want to look at this from a archival or heritage perspective, I'd say
> there's a line somewhere to how old we should go. I don't see an
> use-case for very old binaries. Even knowing if they still work would
> already incur in a maintenance cost.
>

Agree, mostly was a fun challenge. I was also curious to see until when
we can go back in past from 2026.

For the "maintenance" a scheduled CI job running nightly is a free thing
for me, but I understand opinions on "maintenance cost" may differ. I
also co-maintain tests/docker with Alex, so I'll be the one taking the
load, and I'm fine with it.
  >> Images have the absolute minimal content possible. It's only qemu
binaries,
>> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
>> tool included. As a result, images have a size from 149MB (v0.12.0) to 1.48GB
>> (v11.1.2).
>>
> 
> No shell means the first thing to do if one wants to debug the image is
> to rebuild with a shell in. Not sure how frequent it will be, maybe it's
> ok like this.
>

We could leave a base system, for only ~100MB per image, which is not
the end of the world (+10% in size). Personally, I appreciate to have no
shell, it reduces possibility of exploit when running an older QEMU
having CVEs.

>> This series adds 3 pieces:
>> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>>   Ubuntu version when building a given QEMU version.
> 
> This is the tricky part. We'll be carrying code (script+dockerfile) that
> only works on master. If we tag today and tomorrow the old distro repo
> breaks, we obviously cannot fix it retroactively. So we need to be
> careful of where we direct the maintenance effort.
>
> 1) I'd suggest first of all to keep the release image entirely separate
> from the ubuntu image. Treat release.docker as we treat the other
> dockerfiles and update it to work for the current release without
> looking at past ones. Have it clone, checkout, build and gather
> deps. Allow the configure to be tweaked via parameter in case we need to
> disable something in an older build.
> 
> The script would then build a distro image (or dockerfile) with the
> knowledge that it has about ubuntu depending on the QEMU tag vs. ubuntu
> version combination. This would allow us to track the cludges more
> precisely instead of "some ancient distro" as the dockerfile currently
> says.
> 
> This is more of a layering concern and how easy it will be to drop/add
> version-specific fixes.
>

IIUC I think that's the approach Fabiano took, to use Dockerfile from
previous versions, and the conclusion was that it requires some seds and
hacks to have something that work. Internet state is not immutable.
IMHO, building previous QEMU with past Dockerfiles is doomed to fail.

Only thing you can control/guarantee is that "current dockerfile on
master works".

> 2) I wonder if the usage of apt-get build-dep might be a convenience
> trap. In theory, some of the adaptations that are required (such as
> tweaking dependencies) have already been done by us when working on that
> development window.  If we take the dockerfiles from the git tag, those
> changes don't need to be done again and for the issues that didn't exist
> at the time, we can map them to the git tag instead of ubuntu version;
> (we tend to know more about QEMU releases than ubuntu releases).
> 
> Another issue with buid-dep is that it lists _ubuntu package_
> dependencies. The distro can change how it builds the package without us
> noticing. There is already some work done by lcitool, I imagine that it
> would then be duplicated. Or worse(!) be different because build-dep
> might be listing way more packages that what we need for the default
> build.
> 
> This is more of a push towards using existing infra because those pieces
> are already looked after for other purposes.
> 
>> - A script build_release_container.sh which automatically detects which ubuntu
>>   version a given release should be buildable on (based on date). It works
>>   great, and the heuristic works for all our versions.
>> - a script generate_release_links.sh which creates wrapper scripts automatically
>>   using prebuilt images (hosted on my dockerhub).
>>

Sure, lcitool could work to express all that. Would I like to spend time
to rewrite all the missing bits in yaml when debian did it for me? not
really.

> 
> It would be nice if these two could take any hash, instead of just a
> tag. This is one of the things that will depend on what you intend to
> achieve with this series.
>

Very easy, it just needs a non shallow clone.

---

After reading and answering to this message, I feel there are two topics
we can discuss:
1. the current implementation
2. what would we like

1. Personally, I just posted this series as an example of "yes it's
possible with very limited amount of code", and I don't mind having
something completely different. I feel it's probably not worth reviewing
every line at this point.

2. The biggest question seems to be the direction with:
'do we want to provide a single dockerfile that covers all versions' (a)
VS 'having a dockerfile at a time of history for current version' (b).

I think (b) is what we have now (current ubuntu/suse/debian/alpine image
works for current revision, since it's used in CI), and it was already
proven it fails from Fabiano's feedback.
It seems to be that's what you propose also from your answer above.

This series goes in another direction (a), adding a unique dockerfile
covering all versions, independently of all the dockerfiles we have now.

If we agree (a) is a better direction, unique dockerfile approach can be
vastly simplified by restricting ourselves to qemu >= 3.1.0. If not, no
hard feelings, it's just a proposal.

Regards,
Pierrick

