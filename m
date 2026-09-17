Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98DDC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KBV-0005XW-6I; Thu, 17 Sep 2026 18:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7K9l-00049d-Sm
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:00:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7K9g-0004ae-1p
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:00:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLG2Tf2710821
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DRgEwlJmK8bcf4OSTwYjgga3u2VCWo00NwdUB25UExo=; b=d9NOgjAXcqcDjSdm
 FjTEiOR+Dz0xw9epkQMowNB9g5xNm/CxTe7JKV+ogUtLRVd9vIqfSdc3ZQzPJFd+
 r6vyC8iu0MJcNFuBtIOtFmBCFHkzhSB0P1sbN58WrqH74/fIO4lNaIqxMIwc1f81
 nWF9Gre6iFAchT0S82K4TqmBuBwSQbtyhbRONA05zzwFA8Yun8GVgA70leOZyB+n
 VEMBy7yZyx7nCu13mUqCfmrMrUS0YXwnn7Z6CLfAsA1AXorxK15ic4oTqERbB1wx
 9BpHooZf1YDGO5CJqqJqS3HnhAeijuB7bDcq/PgLyHogebokahbCmdlVA/zNXycj
 PbJmJg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grk97sk1e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:00:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2dc92350888so1768005ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789682428; x=1790287228; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DRgEwlJmK8bcf4OSTwYjgga3u2VCWo00NwdUB25UExo=;
 b=XSRnHo2niQgNDZF0iPA1DDxkDq31qvi8MyCg8dvM8A4VIJrVdazd8TxE3Di5wqjTa+
 rPoDG3zwdcJjV/QN9WA8fdhucVlTAyMoDOXlg/csm/CpT8oQOkbX4lX5AJGhgbXZY+sL
 X2YzgotoFPHAjh8o3Xj9CFRXdHyan2Vr9uof3Sxg/W/dD7mPWsuPeeLLocLRdic8TeCZ
 UvlOdylcjC3SqUlkJZml5mvFERwuUxsDOQ465O+H/ggDN1GbKAoz6MiRMQqFyYsjaoVz
 x55JBVEtFpEUp+E/ndtC7rr/FOFV814pz8O9BkN1JBrdHApgFsCPNB9LtvghVG4i9MUg
 7oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789682428; x=1790287228;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DRgEwlJmK8bcf4OSTwYjgga3u2VCWo00NwdUB25UExo=;
 b=o3tRfEegZy/3v7S83IiOU2zoof6QJuoqTzQXV5ohhmgudLx7WpaBLdmZ8cJz+Bxcmd
 dBhljQKJABc4gkEZkWMFgxvrJhz4AR9e0XmxO2VUK4E7UHF19MNUiOzq1ObcakStp7vZ
 oNDtSWL3vYdHw4gLT8dKxDK5umKe4d+JqYYbNxaUe/pc9jnNXSLe2b2Hg+f19nTCzfw8
 C27vWo7IMABgHhRnDJSUOcSXw2TRiMCvunVivoVii1Q+o7Ba1icPWU5iw2VKReGQLKL8
 9Avrdj696z/ZEfB/K0JZrnWbGsHrHrk7fLYtc7s61u/yY9jnAHEMGIRXp9EOd6/G4Uza
 dDwQ==
X-Gm-Message-State: AFuF++lWQjvCYsLd5KSIax1vuTg/bH+mxnlA3Ssg55jCvlwVBsmJ//z2
 9qFLZ3K0jpwenuXyE7C7E3/JpGQENzNR/BMsH0Ip1PVVWcoAV1JdhOBhNTbdr8L396MuIDYWCWO
 wOViQTqAPrRz12SU+nddVEPu0ZI9IShbsfDT2NgAOsY+fvAyfRgilQBLUjw==
X-Gm-Gg: AYBFou1juoraLp0b0DmBj3oqryoqyh6gjDkn3RU44igF0t3otDKVFcD9yAd8GX1Z4GP
 Ssrdh4Z/zYgpG7K51qb2K9CEeBQby/ZvJlxzpEwehWjsrYb4zY+LVJmrvBlr8R9XoV9LfGfk2mg
 59kegYcSZ+1hpRIREcjIobbUCDftUIXHR0SxbUmUCcW0qTfiXW9/RLh989YUlGErgZJ87xN4bJ3
 Qs+Do3GgRYxin3ERkc0Dj+aSPk0mkwQI19EiB6ZEovl415RqGBRdZHCd3brCBV/LR7H4g3G0rqb
 rbV+U0cRtOUUIL0MmdGmx7yEIdobLrBeWMuiGeHStRPfKdCJftkaA4AAIOjm5TJjGxnHDka7roP
 VcHY1IzIA+FOf307aBbRie1jLCq0UvD423k/jxcHQJzfQF8WAd4ox9u/Hqd9ptCnbyBR4
X-Received: by 2002:a17:903:4b03:b0:2dd:ad73:c937 with SMTP id
 d9443c01a7336-2ddb1b989dfmr9654895ad.24.1789682428012; 
 Thu, 17 Sep 2026 15:00:28 -0700 (PDT)
X-Received: by 2002:a17:903:4b03:b0:2dd:ad73:c937 with SMTP id
 d9443c01a7336-2ddb1b989dfmr9654195ad.24.1789682427422; 
 Thu, 17 Sep 2026 15:00:27 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aee8b0sm35823924eec.23.2026.09.17.15.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 15:00:26 -0700 (PDT)
Message-ID: <7a587ac5-b7bb-4c69-a022-3e65e49070c6@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 15:00:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Matthew Rosato
 <mjrosato@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Kyle Evans <kevans@freebsd.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <20260917165602.3405537-12-alex.bennee@linaro.org>
 <a42e8f17-8bdd-4c9b-b465-0428ada507e7@oss.qualcomm.com>
 <87fqz77dln.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87fqz77dln.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LOzz05W9 c=1 sm=1 tr=0 ts=6aac62fd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=cSby643O2cv9IJhTg8EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMxNiBTYWx0ZWRfXw297n+Np1+D0
 8WDEtN+BQKh9h2bfdwfgjcd5la88TDekCvUX4W8qO7Uvk9MGAyHZcMaeoaieDO6xW3B+tBW9uzB
 aWo4jrNENr50sJW4suw2ZRH43xPQhC1Dpvp8OO3y3eyvzb2TDdtjFbrYUljOku8rhQZRqc5b0By
 6chMdhYpRlF6PwzX7F18vQvua7nsU9OkltLL5cnqDaQZ3A7El+qL3o5fgziuC6BGzpQiNou0vSR
 4d8zQFEcgYqZ3npdwa7CILOjqDZuDoTXuYvCC0BCheaMe8YG2sjjnYpGGWfRssnxkdAZGpnilXS
 Ls4mbjT2eyDC/ujYkcNhd6cdNENxrW7jc9b7BjGsN2TOpxmvDz2t6aQtMrzTWX6qXds7PXrvr+U
 6+eQLWRe8lhp/uWYIjPpctRiQbQGnVZdH3PYLMERSC/8Py6QUuM2/ymUnkDVdq+y17/mMo3DvFY
 rd4j5MoRQOZowaHrhZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMxNiBTYWx0ZWRfX6AmFqG2FAqJ0
 pXe3YXNHpLn1sIC4cACKqhkqeGQQdtpsO9ufR/b/Ls7jfXuH7Q37NjSx8ooteP7uifOVb54LiJH
 Q/706TZVpxjdkUPXRax/+W0gHtlSWfQ=
X-Proofpoint-ORIG-GUID: p4pwa71TlsX9j3AdAAux8Co3doF2SOQ9
X-Proofpoint-GUID: p4pwa71TlsX9j3AdAAux8Co3doF2SOQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170316
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 9/17/2026 2:49 PM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/17/2026 9:55 AM, Alex Bennée wrote:
>>> The caching logic was a remnant of an older time when we had multiple
>>> shared layers building that went into the final image. It was arguable
>>> that it worked back then but it is definitely not needed now so into
>>> the bin it goes.
>>>
>>> Tested-by: Richard Henderson <richard.henderson@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  tests/docker/docker.py | 148 ++++++++++++++---------------------------
>>>  1 file changed, 49 insertions(+), 99 deletions(-)
>>>
>>
>> After testing this series, it's not a good idea to include this patch.
>>
>> It forces a systematic rebuild, even when image is already. This has
>> three consequences:
>> - verbosity: we see build log systematically
> 
> You asked me to drop the verbose/quiet switch patch which addresses this.
>

Which is good, because it was hiding the problem.
I was waiting to see the series is in good shape before testing it.

>> - slower: running a noop rebuild takes time
> 
> how much time? it flies past when I run a rebuild.
>

For a no-op tcg-tests build (i.e. with tests already built):

- With current patch:
time ninja -C tcg-tests
...
verbose pull and build
320 lines of output
...
real    0m15.817s
user    0m1.342s
sys     0m0.840s

Without the current patch (current behavior):
time ninja -C tcg-tests
[0/534] Generating tests/tcg/image-debian-all-test-cross with a custom
command
[1/288] Generating tests/tcg/image-debian-hexagon-cross with a custom
command
[2/193] Generating tests/tcg/image-debian-loongarch-cross with a custom
command
[3/156] Generating tests/tcg/image-debian-tricore-cross with a custom
command
[4/135] Generating tests/tcg/image-debian-amd64-cross with a custom command
[5/84] Generating tests/tcg/image-debian-xtensa-cross with a custom command
real    0m0.704s
user    0m0.504s
sys     0m0.132s

>> - network dependency: docker.py --registry triggers a pull, which fails
>> if there is no network. It breaks offline make check.
>> Also, it slows down things too.
> 
> we should be able to gate the registry on network access.
>

It's not as simple as "is_network_connected", there might be timeout
involved in case network has issues, amplifying the problem.

>>
>> So, let's drop this patch and keep the caching mechanism for now, it's
>> still useful/needed.
>>
>> Regards,
>> Pierrick
> 


