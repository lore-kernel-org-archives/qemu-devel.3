Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CA0C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGQe-0005R9-3Y; Tue, 18 Aug 2026 05:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwGQc-0005OV-JH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:48:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwGQa-0006Wx-Rt
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 05:48:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I8BGhi644982
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 09:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 etzsusZ8kr1VTGReg82/z3LxHL3W0N0aU/PJQoemiyA=; b=nbpnRK4U0pTDmnWg
 5d3X3HNrlqGJ2zwbWNn1NZGJvc+nTqnnAkSuMrUqqFyjF6iafxSI1e9DXT87pTjl
 +eN3gaMdD43lHxpenorLWyGimT5UL8sgo0atDVtnRDvKBAFAecbHBoaJAnHZabrd
 +CBLTXehiLbYQswKFvJm1XHMnwqSvA75V9U9ChVEJotFELyBx9Mc28YpVDMq/KoN
 sRsznQFCdoZ6yXwAlCSfrujgyPDttECuBKMkC6i+IotlgVn3j+d5fWPWmkZwb/dR
 /3jLDuY6dOCq9SdognlEQChWdvKc+vvq5q3ApUIDME/52lQsl6x6l5LwP984S2H5
 FD/oPA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4611bwe2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 09:48:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a97644aso50147411cf.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787046494; x=1787651294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=etzsusZ8kr1VTGReg82/z3LxHL3W0N0aU/PJQoemiyA=;
 b=iDFIbv86tmbnDfKIDWgR95mjTrtYVVhE9Cf2/7IbWxvwksucCvFO2ygChBSWe1ZNC4
 F5xoq3zpJ+yjop2xwXvxSNbre/RIqZTScygpwb5gj5LiF+Fk8Yj9KZnz7dWOkg+hqfJV
 UXbmzoJHhOAtMeGH+qlp2+72LpS6nUxgc48Y2sgxeB4CNuwJbwTASvIqtR0919CSm7Su
 Oh0323hlSvB4+ZCbjx7RIwO6KRTuSrSgqfwyzqJK5wBsNWkEFKz4MhLGDd7ytvBcmaFc
 pYm6SOqsznbljC4fg2Kw81ilCpYYT2RNCKlHe27QZScKVG4S5fDiCCDX5bFMsnNpck2z
 pObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787046494; x=1787651294;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=etzsusZ8kr1VTGReg82/z3LxHL3W0N0aU/PJQoemiyA=;
 b=c/0r4arCf0g32Q57zmp+DAkmrdF6VjVAN7sEPNNMeRXMudryrDH6yvYvxsxnumpzYm
 DVmf2prXsjDefKxEF7U3g6rRIHIv3WGev60Am85cq7fNWXr3kGdAZXAp2BgeRBixzMWd
 9Bhj4bSK8AgN4aH5gnzLoTyFpew/V23ao1Fi9yiqvtpQOjpvf1vp14J+Te8Ms9LAKqwC
 zbTULzI0xxqyhVuWAEQoHMn6yPyY+cWg+C7iomMq/kqSk+pONYVzL2AtWuUUVrmrhdiF
 iL6A44vJpfXsAc3vtsQN6npYw4BxFuz+8shoeFMuGGxPRoEYinJEXc9BS2HoUa3WKcuN
 88jA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjBQqCAUX2Tah7PGRZ1RkreNBbnfJ6vLVxFxOGS5T+oiTf+JJ2xxqkioj/0hlYWYpV/AH2WCwS86aw@nongnu.org
X-Gm-Message-State: AOJu0YwHnK8IoIZG7jMPMkR7x+fYckn+TWGluAfCufkw6MtdkcC5CT3p
 aDPn8YzuBnKEj+EdIIGu5qyhK2KGirrzcuEGD74NXrqw4h/5QVOBjfKMRH+EQ0WIZk8MaMeQ0Fa
 zUlwyWC4sTJ2IIrInYKB06vkYEXEh25MkVm7TAyfZYNmYPlAEAnX5Gckv1w==
X-Gm-Gg: AR+sD12NRz6s+MMquOkC/w+mHJhBdNUq0cpbQxCJkra6ESvXtSwThFvf7Ih1uvy7cPM
 rfcz5tc5ZZtpQWD2ayTAYV3d2yMwcyaP+BROTWYJ5UDceZE6luCJ01tv7aPbc2WYf8LKWHtp/Ic
 2jwQbQmZwQoBQjI7vpzmOHo2eO4yRccpPnzVnfZg5A1+n4deE+bW6E3C17AZsGFujmVsf5ve+AJ
 AnIFU9XLLiFKhyXrahfLCEtPtXfKuD8a2Bv7QWSagafB7JEzcT11v8SeO7GQzRwGUGrcIBCEO4f
 7RGENwrSxiI5F92EKRe6IOqcykVaIIgBMLiL1WKwCovwSu4y44KzW/Nxigcd1epGUajUNQOabQD
 phmsLBz2ioszmAOcE5ZrJDlg7EgJD5iGewr4=
X-Received: by 2002:a05:622a:4c8c:b0:52b:71dd:c92c with SMTP id
 d75a77b69052e-52dbd5fed4cmr70190941cf.2.1787046494366; 
 Tue, 18 Aug 2026 02:48:14 -0700 (PDT)
X-Received: by 2002:a05:622a:4c8c:b0:52b:71dd:c92c with SMTP id
 d75a77b69052e-52dbd5fed4cmr70190651cf.2.1787046493879; 
 Tue, 18 Aug 2026 02:48:13 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b783basm11006135f8f.30.2026.08.18.02.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 02:48:13 -0700 (PDT)
Message-ID: <62f43599-468d-4bc2-b6ee-7dd4c5eece1c@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: warn about hunks which only add blank lines
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260731134046.1015479-1-den@openvz.org>
 <299fa07a-9a40-4473-bfe7-38aab7248a79@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <299fa07a-9a40-4473-bfe7-38aab7248a79@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZzeW4Qk1OfUfwRqCL_lYw17I0BjtP0BS
X-Proofpoint-ORIG-GUID: ZzeW4Qk1OfUfwRqCL_lYw17I0BjtP0BS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3MSBTYWx0ZWRfX1PnnEsU7X+p5
 RFqWKm86KuZ0hHsdWcB9SoON4tmq9PicUcbi0Joz15JDojGT4Igc6N5x5NkrFXQeV3zoVzcYURe
 prBRK83PbD6rjSjPkXuLlPArwdwyI/w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3MSBTYWx0ZWRfX42tAdTvegr9v
 J7q59+OBx8AMXryLVkavquWGnbPifCp0CcLrxkGcYxP9ja2x66kadWCAmB0WwCe6B9BaFFRmBHl
 evGLJONO9K4vWufblnuCFXuelqtcvXSi00voriXa/MdGiqJE+vjTCrX+hxSQM3bS80+yzBxhbO1
 GRGyDxvGr+ta1z7pRPj1O9McbqWV/2zrq75XpIsHPhaP6Y9LSsJ8dZvVDsgvwKo8Dvil8tRiCFR
 7PwL8cO27wcsiw1mMEHfZOcK4wvf/oujImYSY2wVIIA3thTtFlpJ3WEXnJErtTdbukDZcihihgF
 rN0S+SFT7V1/vOFe4MqPTGWutTgbNspLezgRJZL4+q7nK2AhHDbRTb0o9TaJuz1yCGHAKpDLR9O
 OgCTxXz3ASB4qNU/syLZdpF3JGagtkZU3bJPVgJm67WgOYo3HiUd6gPZ78ydweI253cp2ZMU7hv
 bA5QOT49q/QivX7kMFA==
X-Authority-Analysis: v=2.4 cv=UslT8ewB c=1 sm=1 tr=0 ts=6a842a5f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=6rqHouBjAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=BYxkUbT1f34brgHVcVwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Hx1yvPaMooE3kwe23bt7:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 18/8/26 11:29, Denis V. Lunev wrote:
> On 7/31/26 15:40, Denis V. Lunev wrote:
>> This email originated from an IP that might not be authorized by the domain it was sent from.
>> Do not click links or open attachments unless it is an email you expected to receive.
>> Patches sometimes carry a hunk whose entire content is one or two
>> added blank lines. It changes nothing, it makes the diff longer and
>> it survives review because nobody looks twice at a blank line. The
>> blank line itself is perfectly fine, the gratuitous hunk is not.
>>
>> Tally the added blank lines and the other changes of every hunk in
>> the pre-scan loop which already walks the raw patch, and record the
>> hunks which only add blanks. Such a hunk is then reported at the
>> first blank line it adds, so the warning carries the usual file and
>> line context.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Chao Liu <chao.liu@processmission.com>
>> CC: "Daniel P. Berrange" <berrange@redhat.com>
>> CC: "Philippe Mathieu-Daude" <philmd@oss.qualcomm.com>
>> CC: Thomas Huth <thuth@redhat.com>
>> ---
>> Note: this patch is sent on behalf of the yesterday finding inside IDE
>>        pull request. This should be found with a checkpatch.
>>
>>   scripts/checkpatch.pl | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 03f35e7501..dfa9878006 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1567,6 +1567,10 @@ sub process {
>>   	my $first_line = 0;
>>   	my $p1_prefix = '';
>>   
>> +	my %blank_only_hunk;
>> +	my $hunk_first_blank = 0;
>> +	my $hunk_has_change = 0;
>> +
>>   	my $prev_values = 'E';
>>   
>>   	# suppression flags
>> @@ -1583,6 +1587,10 @@ sub process {
>>   		$line = $rawline;
>>   
>>   		if ($rawline=~/^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
>> +			$blank_only_hunk{$hunk_first_blank} = 1
>> +				if ($hunk_first_blank && !$hunk_has_change);
>> +			($hunk_first_blank, $hunk_has_change) = (0, 0);
>> +
>>   			$realline=$1-1;
>>   			if (defined $2) {
>>   				$realcnt=$3+1;
>> @@ -1633,6 +1641,13 @@ sub process {
>>   		push(@lines, $line);
>>   
>>   		if ($realcnt > 1) {
>> +			if ($rawline =~ /^\+\s*$/) {
>> +				$hunk_first_blank = $linenr
>> +					if (!$hunk_first_blank);
>> +			} elsif ($rawline =~ /^[-+]/) {
>> +				$hunk_has_change = 1;
>> +			}
>> +
>>   			$realcnt-- if ($line =~ /^(?:\+| |$)/);
>>   		} else {
>>   			$realcnt = 0;
>> @@ -1641,6 +1656,8 @@ sub process {
>>   		#print "==>$rawline\n";
>>   		#print "-->$line\n";
>>   	}
>> +	$blank_only_hunk{$hunk_first_blank} = 1
>> +		if ($hunk_first_blank && !$hunk_has_change);
>>   
>>   	$prefix = '';
>>   
>> @@ -1780,6 +1797,10 @@ sub process {
>>   
>>   		$cnt_lines++ if ($realcnt != 0);
>>   
>> +		if ($blank_only_hunk{$linenr}) {
>> +			WARN("this hunk only adds blank lines\n" . $herecurr);
>> +		}
>> +
>>   # Only allow Python 3 interpreter
>>   		if ($realline == 1 &&
>>   			$line =~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {
>>
>> base-commit: e1705a25aff35635c360bbaba4c2731d019a422a
> Guys,
> 
> does it make sense to continue discussion or this patch
> goes to /dev/null as nobody is interested in?

I'm not sure why I am in the Cc list, but TBH I try to not look
at Perl changes for my own mental health, so I'll politely pass.

