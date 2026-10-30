Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3802D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Bq7ctBpC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kG7YNYzP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtH1-0007uf-VX; Fri, 30 Oct 2026 16:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtGw-0007uA-Rq
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:32:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtGu-0004NK-WA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:32:22 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIhx2C3776953
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I7ofQHPDYUhsx1VmN5hK75S+MsRjqV4oOEDVpjwlSyU=; b=Bq7ctBpCKlFedg8g
 4VdZw6WU8Qlu/2m9SDoQ/au6sGNFCfae/d4Ipgxr0cn9D8xXw++yetztaCwma2GP
 PcTjS5SjdCht/AItdedoGnXdFAcOF3MTQxMuoofiujshkIR8u1UxFGElSRePQqRR
 sqXrR97jz5nxksfVFZRZg9XA26l90w88DFN6kORgFnG7xtfRo2AbrQLLXNjrx1+0
 DmEpjYuRSL64KiIrY+bw1V6VH10DE832+CHNzpH28d1rmuB9osG7vK0ogmqn2lDG
 Zm8MovZ3LQJ90YTKLcYKDtPRvuNIGLb3wjxfhISrfrBqA7DijJlZC0geO065AFpx
 /pf1qA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0s9ra56-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:32:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3662e7a9299so4149050eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793392337; x=1793997137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I7ofQHPDYUhsx1VmN5hK75S+MsRjqV4oOEDVpjwlSyU=;
 b=kG7YNYzPuEO9Ivi66K7+DuB4d9V/J5UptSNCTxBIC0I4NzbR6BOjsFgn3MVYMPL1Kr
 7mtwkDFDiXfcn/pqMKqUnFHES1Bw2pIm09VIPyWs6qZP3azFasBl5bW0/ueV52e5fZbx
 visYeFnPFIQZbicRmZbcgqo59dD9uJlYwaTZ0yPoj3NKR/1ZGUKkYbn0VOlked3IXPmZ
 7e4V2j42UGmrNAxgKqPGPQHLP0W5zhT1NuO964DanJVH22VPYwic28Y6CuftPa/UlmsI
 o8CWXaOET/+JUgvnuVG1859Jklv76zKseR1VRMhqW/UKdD5tTcwPGBOPZRL/IAoj6dy0
 fMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392337; x=1793997137;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I7ofQHPDYUhsx1VmN5hK75S+MsRjqV4oOEDVpjwlSyU=;
 b=UUSA/NO7OCz4K/Y3IojhTPBfnLHEfJQtPs4sI1rhM+CBfBIwJkGH1EkEjKtXl1cxx4
 2y1xnA2TsHaCEPRlE8pvA+dRegme7D67cb5GETaN0dXw6LpEQgTEf2V6byxWUODBAnC2
 M1XZN7O7uS3BnVXLTfq3LVGcXOc/kSVORDcHa70+hzBb5+iYVOsmC4Jo1gSnGnemLWTA
 dw1pw8y3iamYVxXLXopXCJoMS4u+3mpz8+P3MBlgUKkyYKo05PTfmftkkdTAvgxY/Wvm
 zY2pb221iXc9x4OFT/e3R0DdvGGJ6nhjBgdQ30GGussAvNFd84AmUVWVYUoL54+mPuS/
 DgvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByiPxOv0BpWhGWh0//7X2Ax4XrDjJGJXGFSBJ6C0w/k5sAGP0ivDmmSF2a0e34UWHSYlTcTceD5mcwU@nongnu.org
X-Gm-Message-State: AFq9FYItbc2Sf6CUdyI6eTnYkb84eL1W7twt2hYa4WtuguO354345Zdf
 tXT/dz6Uwr15fY7gy6PslbhTSGJlQDF+bEU1BMcjZKdIui0mFXOmX2v1R7vtPXCyWOlWfM7fWGf
 uj5kb2VMWgKUcWddnSqsUfK1KOmPOJig21TX6aBU+fKdOzWpbyetem9ZN9w==
X-Gm-Gg: AYBFou1aO1ukz4zqLmSgL5c9AA0cDmypUeKQycv1oOSL5H7j794pnSEdw3kzE4iCu3w
 KM+/xfAY0cGw8s9jpQo+hwSz7j/hUZmjNLhoRKLv/YvL4xEZoZsb9CpRH0LF5JvvftU7tLe6ryp
 LooGLhqMG0hQGB63//i6wknqxFgi7i2/HILhw8EyMiU1HVK0XV/cU3yfQLtjByQugau48zH7anH
 owwlD0o82xN0KG/zLPkb1fxIk0Cia8oJCyLEAkdzlnqR5brXDUSpBuQMVHnaLEzOFs11hK/OLCz
 B+eo1PFMr6dmLweyca6gxr5WjSBxrbBenzO1Mtx3JLz30Uck7Hi+KfAGwURDMGD/vZ5QJHn2nMP
 ieTaoEPQqEei/WiowwQ4G4s1Bf5H27CCt4ZjL7EvDQ6FycJ78HZTw2euFKYEfQNbB76kB0uZRZH
 AJROZ9peMqToo1vdbIwlORebtSUDYmcLHqLHNwxP+OjCk=
X-Received: by 2002:a05:7300:fb88:b0:36a:437a:4c00 with SMTP id
 5a478bee46e88-36a437a4eeemr6192637eec.24.1793392337303; 
 Fri, 30 Oct 2026 13:32:17 -0700 (PDT)
X-Received: by 2002:a05:7300:fb88:b0:36a:437a:4c00 with SMTP id
 5a478bee46e88-36a437a4eeemr6192590eec.24.1793392336763; 
 Fri, 30 Oct 2026 13:32:16 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm9288786eec.28.2026.10.30.13.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 13:32:16 -0700 (PDT)
Message-ID: <f43f22f9-c782-49a4-ae4f-a8fbcbbd0a6f@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:32:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/checkpatch: validate fixes against upstream
 repo
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>
References: <20261030183054.2875292-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030183054.2875292-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bPyDs/+Z c=1 sm=1 tr=0 ts=6ae4fed2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=G2UGLN--7Ljvuk1bJC4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vczGS7mp08bMi4Pp_Jn-64LXere1Y0mp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfX9KAQSENc2NWe
 pmJRRvA/C90P7cIGYwRCZL2y1citcarJr+YM00YZHb+2Pj6nSHaNPz9p7TLWWHjHc0gPm2VUx4n
 Xmodm4+50v8YeSldQy/efrwXtuh3MF2qIwMOUq4WYlOppXfotPjqwJHH49CdnQRRsmP/yx43eYH
 m23f6yHXocgztgg5d5li8ME8zlFclMAX1HCy5dZfPTAHbgFlXnSu5n0hH91Soy/xkFUNP8UpLbW
 fkPiK3tbc0Cs6cm91bSiq5cjgi0kXE/bWqrgkt4ImbS535EqTGgKlOAoKsV1j2F1r+JS09YHMpV
 jb0NM29TDt+bzb/4tp4awwBLz2LFjmBqkvLKTcHJOT4uZ9HLWD55ij0Kkg0crezYjxuP6GRSkfm
 qL+NGKAPQTJNdPa1DKAZGXW1+m6hncsWCJ7K2BGnBjUbIUGA/7uJ6XWEH1HkbiVttmj9liWlcM5
 c4vn5Syzgc5RqtCRkyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MSBTYWx0ZWRfXyvSfF9w7Iec9
 NtxSnteod75AWE4zZvGvG0Z1yt4r1+MgKsZ3oOcEVNNGjwEGYGSl8UdJchxzzBLaq0McbhXlw0n
 WJoKX4r2sqwDIJkYFNoqlydw6PyiIHo=
X-Proofpoint-GUID: vczGS7mp08bMi4Pp_Jn-64LXere1Y0mp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300081
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

On 10/30/2026 10:30 AM, Alex Bennée wrote:
> The current check for a referenced fix commit relies on the developer
> keeping their master branch up to date which is not always guaranteed.
> If you create your branches directly from the upstream repo this will
> keep failing. Besides the local master could be anything.
> 
> Improve the logic to divine which remote is pointing at the upstream
> repo and use the remote master to check the fixes.
> 
> checkpatch complains about the line lengths but this seems to be
> standard for the perl script so I didn't try and fix it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
> v2
>   - drop hard coding of remote in favour discovering it
> ---
>  scripts/checkpatch.pl | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4984a258ee5..cc311684d66 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -586,6 +586,37 @@ sub git_commit_info {
>  	return ($id, $desc);
>  }
>  
> +my $git_upstream_branch_checked = 0;
> +my $git_upstream_branch_cached = undef;
> +
> +sub git_upstream_branch {
> +	return $git_upstream_branch_cached if ($git_upstream_branch_checked);
> +	$git_upstream_branch_checked = 1;
> +
> +	return undef if ((which("git") eq "") || !(-e "$gitroot"));
> +
> +	my $url_regex =
> +		qr{(?:gitlab\.com[/: ]qemu-project|github\.com[/: ]qemu)/qemu(?:\.git)?$}i;
> +
> +	# Scan configured remotes for the upstream repository
> +	my $output = `git remote -v 2>/dev/null`;
> +	for my $line (split(/\n/, $output)) {
> +		if ($line =~ /^\s*(\S+)\s+(\S+)\s+\(fetch\)/) {
> +			my ($remote, $url) = ($1, $2);
> +			if ($url =~ $url_regex) {
> +				my $ref = "$remote/master";
> +				`git rev-parse --verify --quiet $ref 2>/dev/null`;
> +				if ($? == 0) {
> +					$git_upstream_branch_cached = $ref;
> +					return $git_upstream_branch_cached;
> +				}
> +			}
> +		}
> +	}
> +
> +	return undef;
> +}
> +
>  sub expand_tabs {
>  	my ($str) = @_;
>  
> @@ -1914,9 +1945,12 @@ sub process {
>  				}
>  				if (which("git") ne "" && -e "$gitroot") {
>  					my $hash = defined($cid) ? $cid : $orig_commit;
> -					`git merge-base --is-ancestor $hash master 2>/dev/null`;
> -					if ($? != 0) {
> -						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
> +					my $upstream = git_upstream_branch();
> +					if (defined($upstream)) {
> +						`git merge-base --is-ancestor $hash $upstream 2>/dev/null`;
> +						if ($? != 0) {
> +							WARN("Fixes: commit $hash is not an ancestor of $upstream\n" . $herecurr);
> +						}
>  					}
>  				}
>  			}

The gitlab/github is a bit arbitrary, but should work as it is.
Acked-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

