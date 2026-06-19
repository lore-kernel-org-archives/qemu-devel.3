Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CC7CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 16:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wacHu-0002dK-82; Fri, 19 Jun 2026 12:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacHs-0002cx-Lg
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:41:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wacHq-0002H3-Nh
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 12:41:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JDAZaN175117
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 auOCiNm66y2pYIwqrXtBQCwLeBiUDODlTak2N13mpM8=; b=TPFtWigXarJwwlBu
 WQbY0IloQ4/ilR+6nikArzMORz4EGRlPUMRvB/pWzzzka+kr/Q0RLTuDccDh4AB9
 9NHgG/3l2B6VHJolRLffqH3lgR670O626NNslfNV3GsD41twSxJpGR3sLSXZ9hRS
 C2dXCZ0gHdVHg3cNkot0Y/A0ozaygynnuzc7NAtNegq0+IudDG6px35/HQ0+JaYj
 lR2/tLAg2CVBZm9ukPSjehacxWsgE4w7Z/qcAjmvpMHsWERRCc7OL5il97pGNJ8n
 Ro0PAN+PLAePnCPwInPwkJ4BmXnzDYnJCy6X04GuBO50Fo5A23QI+BnH6BlP4kQ2
 TBle+w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evkvf4mvb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:41:43 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30beab99453so3669035eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781887303; x=1782492103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auOCiNm66y2pYIwqrXtBQCwLeBiUDODlTak2N13mpM8=;
 b=kKE2hVh4ibBWEcyrOOJlUmZZtKNmJu+886XYOMpf9bUFv0YdjCK0Xr3EKHUJRnzInq
 Q9VtG4+fwcSJsSGiKmk/J6HRl2GK6s3uZUC19to1rk2obU15FgB1X6+/JdcXDaLEgTd1
 HBYupP3Hu6o2hyEFVxADQLUpELbDdaEqValPe+DDKw/bwuPA7ZHUzR5TIomBXE9e230C
 kUolzBTobEnERlZYgBAFZNF6Dke5nZexaZkrgMJ1xNANVeuWvrRm8CvFDJPNHuIze1Lt
 Pf+ll0BvpnHDG31jkEISWQKuEx/aYTkGA5gm0EuMPnrlxpH6XIc7g1nb79G/rc3zGT6x
 ssGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781887303; x=1782492103;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=auOCiNm66y2pYIwqrXtBQCwLeBiUDODlTak2N13mpM8=;
 b=EfWYnpsZoGCnRLOTHh6IqgJZ+24XY1LdOQptyeIErbd8EvOltSTMEBcN51/wqbtZrC
 9WOUfw6n5dNoMpFVt0zYl2051TSWaAxS3cMd6ktPLWPLSC7oIpLNkVsmdt35JONr7J0M
 4nQSJx81ogrqXdWWDVejZekFRhK+OfE+Ams5xqP+9xxZfvw/t2f8iPR/jpCOVWNjsrs/
 ZYYES8cwjIgBY9K1W80jmFOGG7xwJw42Uc/s4l47OEuDgl7IXY0OQS3rhDdNp+K0LIz2
 A6hI8tJv3l32e/qKpp0d5D5U9RAJXGGEQfii/qFiQAahnbYojwvsU2LLPgQLsIPJ7iyC
 e11Q==
X-Gm-Message-State: AOJu0YxJIEvaPxufHbQbRVml1Qv9taRm01gizEvFukOz5RFtbYouSUKj
 kL59aTwT6HIVXM2qIXQRkRI/xNXDyOCoGuwFJDnGtTTWi/p0ul6Q6/WFUGMZuNY1echRw6s+7yg
 uBgmiUxr7JTROCnJ775je79HC2v1dJaYD7B4kOHcYF60HHQlSF1gBNeMkvw==
X-Gm-Gg: AfdE7ck57yIjh9zqyigLdG+/HBAP4goITX5UiqdGqrBJeRkhrhLXQcjL1EgP/ZJMdWk
 i0vsol6TdXSFlAKK20POsyjfHhKbBR2la6wBbdXz1j94vOuCO6894lEeE/MDhEPmq1aruiMzHJ8
 DhEZkTjuD57KKJucCJYq/DKSHfjCAjZSwDzBTcPptHsDToZbuxTPvA6xkiKm0gxJd1SMCPqQNHZ
 8qqhfVJNxW5lZYplgYxA8lSQsDgJInj+RvMlqTuzqNHlAy6vMw5DeGjqpXy5jt2oZJ12YV0eyKx
 mvvGZXXyze9X6/aJzZE6/y5IQrgRXY6AeH9laUpOs94vvHOp/kMuUvaNfkh69T8cFSFPBNRfvEK
 nTB1YN6YyA7Gym6DRjXOMnVJsKazYgXHQovvtewnKSy/DwyMfpXEOfFdIIL2H7QUTokNn5GYG3H
 MjrOo=
X-Received: by 2002:a05:7300:c89:b0:2ed:2942:34ab with SMTP id
 5a478bee46e88-30c06fb34e8mr2199645eec.3.1781887302765; 
 Fri, 19 Jun 2026 09:41:42 -0700 (PDT)
X-Received: by 2002:a05:7300:c89:b0:2ed:2942:34ab with SMTP id
 5a478bee46e88-30c06fb34e8mr2199632eec.3.1781887302124; 
 Fri, 19 Jun 2026 09:41:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bdffa83sm344937eec.23.2026.06.19.09.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 09:41:41 -0700 (PDT)
Message-ID: <624606ae-4557-4289-b3a0-d612c9682cba@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 09:41:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: tolerate chmod EPERM when unpacking hexagon
 toolchain
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 brian.cain@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20260619043159.2174062-1-brian.cain@oss.qualcomm.com>
 <20260619135326.1248896-1-matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619135326.1248896-1-matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1OCBTYWx0ZWRfX4BESTiYP+dXi
 hWPMlRhkyaaokC/dg8XWal1pdYkt0mfURpJECIZ8hEoHC+4t8ISDFeXS8wRN1kIqy8gjq2ZPkFl
 0zoYFjc608pD9QD7t/zM0EITdg/ZZRI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1OCBTYWx0ZWRfX7/dlPhy6Kdhv
 cWv3KRlf63CYYtdA6KasjOr64Oz1a09+S9ZLsFscsBT6JL1ecfZ9xTXTEjGFjETSzU31ctZyONy
 wLl+SYTClVSRVnBNv1oFhYXY0q2gd7T/etkjVQ3flvq2gn1V/LA2W/lqSvK55/QE2toj5B8AG3b
 Xze0t4pBy7jsr6ZDm1tO0NUfXwhy3FwSrrj5VdzoBQSVGz8M7R19UCLn41/fxtmrlb3MWKtTKc9
 eLtVLvZMVmgpV0MN4vIH5250H5D37cA+SLJQcQq5FFR8zYtVuMG94uR9nNXyv9cfPDI+p9mfVsw
 adeSVmvR05ZeobvemSn/Z4pmhPHfTkIFZiboy2xi9wcPOYL4mIz9rIaho1h4zsuzgCyJC3iLO7L
 q6FqgRvyhREvM8qVE7RyolrJYGIvACsJq9+AN8vYxUHlO6edyBnt++pki/AMQUjasE3esX2S8ET
 Jfg7K+ahdGQhSkf+AlQ==
X-Authority-Analysis: v=2.4 cv=H/3rBeYi c=1 sm=1 tr=0 ts=6a357147 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=aW_wW7zqZxM3tF70EogA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: 8BB599wnXcPPVSRHuoibe8bSeA0l7Ct5
X-Proofpoint-GUID: 8BB599wnXcPPVSRHuoibe8bSeA0l7Ct5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190158
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

On 6/19/2026 6:53 AM, Matheus Tavares Bernardino wrote:
> On Thu, 18 Jun 2026 21:31:59 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>>
> ...
>>
>> Download the tarball to a file and ignore tar errors during extraction
>> with --no-same-owner and --no-same-permissions.
> 
> tar's man page says --no-same-owner and --no-same-permissions are "default for
> ordinary users". Isn't that the case for rootless podman?
>

By default, you're still root in the container, even though id 0 is
mapped to your original user in the kernel. So from tar point of view,
it's not an ordinary user.

The side effect is that tar will try to apply the original user id,
which gets mapped in the range configured by /set/subuid, which ends up
being different from yours, and thus results in a
'Cannot change ownership: Operation not permitted'.

>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>  tests/docker/dockerfiles/debian-hexagon-cross.docker | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> index 23e8bb2fb26..817c903246a 100644
>> --- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> +++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
>> @@ -49,7 +49,12 @@ ENV TOOLCHAIN_BASENAME=clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-lin
>>  ENV TOOLCHAIN_URL=https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
>>  ENV CCACHE_WRAPPERSDIR=/usr/libexec/ccache-wrappers
>>  
>> -RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
>> +# Ignore tar's chmod/lchmod EPERM on the toolchain symlinks and directories,
>> +# which rootless podman's overlay storage rejects (harmless mode metadata).
>> +RUN curl -#SLo /tmp/toolchain.tar.zst "$TOOLCHAIN_URL" && \
>> +    { tar --zstd --no-same-owner --no-same-permissions \
>> +          -xf /tmp/toolchain.tar.zst -C "$TOOLCHAIN_INSTALL" || true; } && \
>> +    rm -f /tmp/toolchain.tar.zst
> 
> Hmm, I think the "|| true" may mask some real failures. For example, if
> the URL is invalid, curl would still exit with no error code, but the output
> file would contain something like "errors" : [ { "status" : 404 } ]. Then,
> tar would fail to unpack that but || true would mask it.
> 
>>  ENV PATH=$PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
>>  ENV MAKE=/usr/bin/make
>>  # As a final step configure the user (if env is defined)
>> -- 
>> 2.34.1
>>


